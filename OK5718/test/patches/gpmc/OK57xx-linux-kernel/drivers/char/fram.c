#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/fs.h>
#include <linux/miscdevice.h>
#include <linux/platform_device.h>
#include <linux/uaccess.h>
#include <linux/io.h>
#include <linux/gpio.h>
#include <linux/delay.h>
#include <linux/of.h>
#include <linux/of_device.h>
struct fram_info{
	void __iomem *base;
	unsigned long phy_base;
	int max_size;
	struct miscdevice misc;
} fram_info;
static int fram_open(struct inode *inodp,struct file *filep)
{
	return 0;
}
static int fram_release(struct inode *inodp,struct file *filp)
{
	return 0;
}
static ssize_t fram_read(struct file *filp,char __user *buf,size_t count,loff_t *ofs)
{
	int total,tmp;
	unsigned long pos;	
	count = min((size_t)(fram_info.max_size - *ofs),count); //min size
	total = count;
	pos = *ofs;
	while(total > 0){
		tmp = min((size_t)(0x1000 - (pos & 0xfff)),total);
		ndelay(300);
		if(copy_to_user(buf + count - total,fram_info.base + pos,tmp) < 0){
			return -EFAULT;
		}
		ndelay(30);
		total -= tmp;
		pos += tmp;
	}
		
//	if(copy_to_user(buf,fram_info.base + *ofs,count) < 0){
//		return -EFAULT;
//	}
	*ofs += count;
	return count;
}
static ssize_t fram_write(struct file *filp,const char __user *buf,size_t count,loff_t *ofs)
{
	int total,tmp;
	unsigned long pos;	
	count = min((size_t)(fram_info.max_size - *ofs),count); //min size
	total = count;
	pos = *ofs;
#if 0 
/*if gpmc control address bus direct, think about mass access*/
	while(total > 0){
		tmp = min(0x1000 - (pos & 0xfff),total);
		ndelay(300);
		if(copy_from_user(fram_info.base + pos,buf + count - total,tmp) < 0){
			return -EFAULT;
		}
		ndelay(50);
		total -= tmp;
		pos += tmp;
	}
#else 
/*some address line simulate via gpio,IO state change and access sync*/
	tmp = 0;
	while(total > tmp){
		if(copy_from_user(fram_info.base + pos,buf + tmp,2) < 0){
			return -EFAULT;
		}

		tmp+=2;
		pos+=2;
	}
#endif
	*ofs += count;
	return count;
}
static loff_t fram_seek(struct file *filp,loff_t offset,int whence)
{
	loff_t newpos;
	switch(whence){
		case SEEK_SET:
		newpos = offset;
		break;
		case SEEK_CUR:
		newpos = offset + filp->f_pos;
		break;
		case SEEK_END:
		newpos = fram_info.max_size + offset;
		break;
		default:
			return -EINVAL;
	}
	if((newpos < 0 )|| (newpos > fram_info.max_size)){
		return -EINVAL;
	} else {
		filp->f_pos = newpos;
	}
	return newpos;
}
static struct file_operations fram_fops = {
	.owner = THIS_MODULE,
	.open = fram_open,
	.release = fram_release,
	.read = fram_read,
	.write = fram_write,
	.llseek = fram_seek,
};
static int fram_probe(struct platform_device *pdev)
{
	int ret = 0;
        struct device_node *child = pdev->dev.of_node;
        u32 value;
        if (of_property_read_u32(child, "phy_base", &value) < 0) {
                printk("phy_base not found in DT\n");
                return -EINVAL;
        }
	fram_info.phy_base = value;
        if (of_property_read_u32(child, "max_size", &value) < 0) {
                printk("max_size not found in DT\n");
                return -EINVAL;
        }
	fram_info.max_size = value;
	fram_info.base = ioremap(fram_info.phy_base,fram_info.max_size);
	if(fram_info.base == NULL){
		printk("fram map address\n");
		ret = -EFAULT;
		goto e_map;
	}
	fram_info.misc.name = "fram";
	fram_info.misc.minor = MISC_DYNAMIC_MINOR;
	fram_info.misc.fops = &fram_fops;
	ret = misc_register(&fram_info.misc);
	if(ret < 0){
		printk("fram misc register\n");
		goto e_regist;
	}
	return 0;
e_regist:
	iounmap(fram_info.base);
e_map:
	return ret;	
}
static int fram_remove(struct platform_device *pdev)
{
	misc_deregister(&fram_info.misc);
	iounmap(fram_info.base);
	return 0;
}
static const struct of_device_id fram_of_match[] = {
	{ .compatible = "ti,fram", },
	{ }
};
MODULE_DEVICE_TABLE(of, fram_of_match);
static struct platform_driver fram_driver = {
	.probe = fram_probe,
	.remove = fram_remove,
	.driver = {
		.owner = THIS_MODULE,
		.name = "omap2-fram",
                .of_match_table = of_match_ptr(fram_of_match),
	},
};
module_platform_driver(fram_driver);
MODULE_LICENSE("GPL");
MODULE_AUTHOR("machao");
