#ifndef __COMPAT_IOMMU_H
#define __COMPAT_IOMMU_H

#include <linux/iommu.h>
#include <linux/version.h>

#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 3, 0)

#else /* LINUX_VERSION_CODE < KERNEL_VERSION(6, 3, 0) */

#define iommu_map(domain, iova, paddr, size, prot) iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL)
#define iommu_map_sg(domain, iova, sg, nents, prot) iommu_map_sg(domain, iova, sg, nents, prot, GFP_KERNEL)

#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(6, 3, 0) */

#endif /* __COMPAT_IOMMU_H */
