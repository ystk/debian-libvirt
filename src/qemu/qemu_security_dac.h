/*
 * Copyright (C) 2010 Red Hat, Inc.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * QEMU POSIX DAC security driver
 */

#include "security/security_driver.h"
#include "qemu_conf.h"

#ifndef __QEMU_SECURITY_DAC
# define __QEMU_SECURITY_DAC

extern virSecurityDriver qemuDACSecurityDriver;

void qemuSecurityDACSetDriver(struct qemud_driver *driver);

#endif /* __QEMU_SECURITY_DAC */
