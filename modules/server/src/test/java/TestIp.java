/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2019 Code Technology Studio
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
import cn.hutool.core.lang.Filter;
import cn.hutool.core.net.NetUtil;
import org.junit.Test;

import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.LinkedHashSet;

/**
 * @author bwcx_jzy
 * @since Created Time 2021/8/4
 */
public class TestIp {

    @Test
    public void test() {
        System.out.println(NetUtil.getLocalhostStr());
//		System.out.println(NetUtil.getLocalhost().getHostAddress());
        System.out.println("------");
        final LinkedHashSet<InetAddress> localAddressList = NetUtil.localAddressList(new Filter<NetworkInterface>() {
            @Override
            public boolean accept(NetworkInterface networkInterface) {
                System.out.println(networkInterface.isVirtual());
                System.out.println(networkInterface.getIndex());
                return true;
            }
        }, address -> {
            // 非loopback地址，指127.*.*.*的地址
            return !address.isLoopbackAddress()
                // 需为IPV4地址
                && address instanceof Inet4Address;
        });
        for (InetAddress inetAddress : localAddressList) {
            System.out.println(inetAddress.getHostAddress());
            //System.out.println(((Inet4Address) inetAddress).toString());
            //System.out.println("-");
        }
    }

    @Test
    public void test1() {
        String localHostName = NetUtil.getLocalHostName();
        System.out.println(localHostName);
    }
}
