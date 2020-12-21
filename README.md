# JSAnalysis

# 项目简介
JSAnalysis 是一款苹果设备信息静默获取的工具。它可以在用户无感知的情况下获取到尽可能多的设备信息，方便开发者对用户提供更好的体验。本工具仅限于技术学习交流使用. 

# 设计要点
- 使用AES256加入签名、敏感信息加密. 防篡改、防劫持.
- 在没有权限获取对应信息时统一设置value为@“NONE”、防止因App、系统的更新带来的crash,对用户灵感知.
- 加入缓存机制、子线程异步获取, 避免影响主线程业务

# 获取信息详情

<table class="tg">
<tr>
<th class="tg-2xbj" colspan="8">iOS设备信息获取SDK可获取信息列表</th>
</tr>
<tr>
<td class="tg-0pky" colspan="8"><span style="font-weight:bold">特别说明：以下部分Key值是有可能为空的，本SDK的所有空值均以NONE字符串来标识</span></td>
</tr>
<tr>
<td class="tg-8ot9" colspan="8"><span style="font-weight:bold">（一）appInfo-应用信息</span></td>
</tr>
<tr>
<td class="tg-0pky">序号</td>
<td class="tg-0pky">应用信息名称</td>
<td class="tg-0pky">参数名称</td>
<td class="tg-0pky">示例</td>
<td class="tg-0pky">可行性</td>
<td class="tg-0pky">可行性描述</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">特别说明</td>
</tr>
<tr>
<td class="tg-0pky">1</td>
<td class="tg-0pky">应用名称</td>
<td class="tg-0pky">appName</td>
<td class="tg-0pky">海豚队长</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">2</td>
<td class="tg-0pky">应用唯一标识</td>
<td class="tg-0pky">appBundle</td>
<td class="tg-0pky">公司名称</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">3</td>
<td class="tg-0pky">应用版本</td>
<td class="tg-0pky">appVersion</td>
<td class="tg-0pky">2.0.1</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky">clientVersion</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">4</td>
<td class="tg-0pky">行为数据采集SDK版本</td>
<td class="tg-0pky">sdkVersion</td>
<td class="tg-0pky">1.0.1</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">5</td>
<td class="tg-0pky">App启动时间</td>
<td class="tg-0pky">launchTime</td>
<td class="tg-0pky">4.32</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">6</td>
<td class="tg-0pky">本应用用户id</td>
<td class="tg-0pky">userId</td>
<td class="tg-0pky">1002231</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
<td class="tg-0pky">需要sdk接入的开发人员初始化@property (nonatomic, copy) GetUserIdBlock userIdBlock;</td>
</tr>
<tr>
<td class="tg-0pky" colspan="8"></td>
</tr>
<tr>
<td class="tg-8ot9" colspan="8"><span style="font-weight:bold">（二）clientInfo-客户端信息</span></td>
</tr>
<tr>
<td class="tg-fymr">序号</td>
<td class="tg-fymr">基础信息名称</td>
<td class="tg-fymr">参数名称</td>
<td class="tg-fymr">备注</td>
<td class="tg-fymr">示例</td>
<td class="tg-fymr">可行性</td>
<td class="tg-fymr">可行性描述</td>
<td class="tg-fymr">特别说明</td>
</tr>
<tr>
<td class="tg-0pky">7</td>
<td class="tg-0pky">设备名称</td>
<td class="tg-0pky">deviceName</td>
<td class="tg-0pky">获取设备驱动名称</td>
<td class="tg-0pky">hwG750-T01</td>
<td class="tg-0pky">Y/N</td>
<td class="tg-0pky">我理解是设备的昵称，就是给我自己手机设置的别名</td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">8</td>
<td class="tg-0pky">设备型号</td>
<td class="tg-0pky">deviceModel</td>
<td class="tg-0pky">手机的型号</td>
<td class="tg-0pky">HUAWEI G750-T01</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky">deviceModel:iPhone X</td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">9</td>
<td class="tg-0pky">设备品牌</td>
<td class="tg-0pky">brand</td>
<td class="tg-0pky">设备品牌</td>
<td class="tg-0pky">Huawei</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">10</td>
<td class="tg-0pky">系统名称</td>
<td class="tg-0pky">osName</td>
<td class="tg-0pky">系统名称</td>
<td class="tg-0pky">Android</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky">platform:iOS</td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">11</td>
<td class="tg-0pky">系统版本</td>
<td class="tg-0pky">osVersion</td>
<td class="tg-0pky">获取系统版本字符串</td>
<td class="tg-0pky">4.4.4</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky">deviceOs:iOS12.1</td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">12</td>
<td class="tg-0pky">系统sdk版本</td>
<td class="tg-0pky">osSDK</td>
<td class="tg-0pky">系统sdk版本比如iOS11.2</td>
<td class="tg-0pky">iOS11.2</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">13</td>
<td class="tg-0pky">制造商</td>
<td class="tg-0pky">manufacturer</td>
<td class="tg-0pky">设备制造商</td>
<td class="tg-0pky">HUAWEI</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">14</td>
<td class="tg-0pky">系统默认语言</td>
<td class="tg-0pky">initialLanguage</td>
<td class="tg-0pky">系统默认语言</td>
<td class="tg-0pky">zh</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky">默认语言可以修改，获取结果同15</td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">15</td>
<td class="tg-0pky">配置时区</td>
<td class="tg-0pky">timeZone</td>
<td class="tg-0pky">配置时区</td>
<td class="tg-0pky">北京</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">16</td>
<td class="tg-0pky">剩余电量</td>
<td class="tg-0pky">dumpEnergy</td>
<td class="tg-0pky">剩余电量</td>
<td class="tg-0pky">0.15</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">模拟器获取为-1.00</td>
</tr>
<tr>
<td class="tg-0pky">17</td>
<td class="tg-0pky">是否充电</td>
<td class="tg-0pky">charging</td>
<td class="tg-0pky">是否充电</td>
<td class="tg-0pky">0、1</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">0代表没有在充电，1代表正在充电</td>
</tr>
<tr>
<td class="tg-0pky">18</td>
<td class="tg-0pky">电池状态</td>
<td class="tg-0pky">batteryState</td>
<td class="tg-0pky">Unknown: 未知状态 Unplugged: 未插电 Charging: 充电中 Full: 充电中/并且已经充满</td>
<td class="tg-0pky">Charging</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">19</td>
<td class="tg-0pky">UUID</td>
<td class="tg-0pky">UUID</td>
<td class="tg-0pky">IOS设备唯一标识</td>
<td class="tg-0pky">xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">这个标识会在卸载应用后会改变，现在传的imei字端其实就是这个</td>
</tr>
<tr>
<td class="tg-0pky">20</td>
<td class="tg-0pky">IDFA</td>
<td class="tg-0pky">IDFA</td>
<td class="tg-0pky">与device相关的唯一标识符，可以用来打通不同app之间的广告</td>
<td class="tg-0pky">1E2DFA89-496A-47FD-9941-DF1FC4E6484A</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">21</td>
<td class="tg-0pky">是否越狱</td>
<td class="tg-0pky">jailbroken</td>
<td class="tg-0pky">是否越狱</td>
<td class="tg-0pky">是、否、NONE</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">模拟器获取为NONE</td>
</tr>
<tr>
<td class="tg-0pky">22</td>
<td class="tg-0pky">是否为模拟器</td>
<td class="tg-0pky">simulator</td>
<td class="tg-0pky">是否为模拟器</td>
<td class="tg-0pky">1、0</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">1代表是，0代表不是</td>
</tr>
<tr>
<td class="tg-0pky">23</td>
<td class="tg-0pky">手机cpu使用率</td>
<td class="tg-0pky">cpuUsage</td>
<td class="tg-0pky">cpu使用率</td>
<td class="tg-0pky">12.91</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">24</td>
<td class="tg-0pky">app cpu 的使用率</td>
<td class="tg-0pky">appCpuUsage</td>
<td class="tg-0pky">app占用的cpu</td>
<td class="tg-0pky">1.23</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">25</td>
<td class="tg-0pky">系统启动时间</td>
<td class="tg-0pky">bootTime</td>
<td class="tg-0pky">格林威治时间</td>
<td class="tg-0pky">1549851830</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">26</td>
<td class="tg-0pky">系统运行总时间</td>
<td class="tg-0pky">upTime</td>
<td class="tg-0pky">从启动到现在运行的总时长，秒为单位</td>
<td class="tg-0pky">1233360</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">27</td>
<td class="tg-0pky">内核版本</td>
<td class="tg-0pky">kernelVersion</td>
<td class="tg-0pky">系统内核版本</td>
<td class="tg-0pky">Darwin Kernel Version 18.2.0: Mon Nov 12 20:24:31 PST 2018; root:xnu-4903.231.4~1/RELEASE_X86_64</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">28</td>
<td class="tg-0pky">现在时间</td>
<td class="tg-0pky">nowTime</td>
<td class="tg-0pky">格林威治时间</td>
<td class="tg-0pky">1551085190</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky" colspan="8"></td>
</tr>
<tr>
<td class="tg-8ot9" colspan="8"><span style="font-weight:bold">（三）netInfo-网络信息</span></td>
</tr>
<tr>
<td class="tg-fymr">序号</td>
<td class="tg-fymr">网络信息名称</td>
<td class="tg-fymr">参数名称</td>
<td class="tg-fymr">备注</td>
<td class="tg-fymr">示例</td>
<td class="tg-fymr">可行性</td>
<td class="tg-fymr">可行性描述</td>
<td class="tg-fymr">特别说明</td>
</tr>
<tr>
<td class="tg-0pky">29</td>
<td class="tg-0pky">网络类型</td>
<td class="tg-0pky">networkType</td>
<td class="tg-0pky">WIFI、WWAN、NONE</td>
<td class="tg-0pky">WIFI</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">30</td>
<td class="tg-0pky">网络名称</td>
<td class="tg-0pky">SSID</td>
<td class="tg-0pky">网络名/wifi名/</td>
<td class="tg-0pky">YOUXIN_WIFI/NONE</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">模拟器获取为NONE iOS13后值固定为“WLAN”</td>
</tr>
<tr>
<td class="tg-0pky">31</td>
<td class="tg-0pky">mac地址</td>
<td class="tg-0pky">mac</td>
<td class="tg-0pky">无线局域网mac地址</td>
<td class="tg-0pky">00:08:02:a4:fb</td>
<td class="tg-0pky">N</td>
<td class="tg-0pky">如果没有连接到WiFi，获取到固定值0x020000000000</td>
<td class="tg-0pky">模拟器获取为NONE</td>
</tr>
<tr>
<td class="tg-0pky">32</td>
<td class="tg-0pky">路由器地址</td>
<td class="tg-0pky">routerAddress</td>
<td class="tg-0pky">无线路由器地址</td>
<td class="tg-0pky">192.168.1.1</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">33</td>
<td class="tg-0pky">路由器mac</td>
<td class="tg-0pky">routerMac</td>
<td class="tg-0pky">wifi的mac地址</td>
<td class="tg-0pky">10:76:93:2c:a0</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky">bssid/ ssid</td>
<td class="tg-0pky">模拟器获取为NONE</td>
</tr>
<tr>
<td class="tg-0pky">34</td>
<td class="tg-0pky">网速</td>
<td class="tg-0pky">link_speed</td>
<td class="tg-0pky">网速</td>
<td class="tg-0pky">135mbps</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">目前有这个功能，但是都没有获取</td>
</tr>
<tr>
<td class="tg-0pky">35</td>
<td class="tg-0pky">cell_ip</td>
<td class="tg-0pky">cellIp</td>
<td class="tg-0pky">蜂窝网络ip</td>
<td class="tg-0pky">192.168.1.105</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">模拟器获取为NONE</td>
</tr>
<tr>
<td class="tg-0pky">36</td>
<td class="tg-0pky">wifi_ip</td>
<td class="tg-0pky">wifiIp</td>
<td class="tg-0pky">无线局域网ip</td>
<td class="tg-0pky">192.168.1.12</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">37</td>
<td class="tg-0pky">代理ip</td>
<td class="tg-0pky">proxyIp</td>
<td class="tg-0pky">代理ip</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">38</td>
<td class="tg-0pky">蓝牙名称</td>
<td class="tg-0pky">bluetoothName</td>
<td class="tg-0pky">蓝牙名称</td>
<td class="tg-0pky">HUAWEI TAG-TL00</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky">和iPhone本身的别名相同</td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">39</td>
<td class="tg-0pky">VOIP状态</td>
<td class="tg-0pky">voipStatus</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">0、1</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">40</td>
<td class="tg-0pky">网络制式</td>
<td class="tg-0pky">radioType</td>
<td class="tg-0pky">移动网络制式</td>
<td class="tg-0pky">LET</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">41</td>
<td class="tg-0pky">路由广播地址</td>
<td class="tg-0pky">routerDstaddr</td>
<td class="tg-0pky">10.255.17.255</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">42</td>
<td class="tg-0pky">路由网关</td>
<td class="tg-0pky">routerGateway</td>
<td class="tg-0pky">160.197.64.113</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">43</td>
<td class="tg-0pky">路由名称</td>
<td class="tg-0pky">routerName</td>
<td class="tg-0pky">112.50.112.48</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">44</td>
<td class="tg-0pky">路由子网掩码</td>
<td class="tg-0pky">routerNetmask</td>
<td class="tg-0pky">255.255.254.0</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-fymr" colspan="8"></td>
</tr>
<tr>
<td class="tg-8ot9" colspan="8">（四）phoneCardInfo-手机卡信息</td>
</tr>
<tr>
<td class="tg-fymr">序号</td>
<td class="tg-fymr">手机卡信息名称</td>
<td class="tg-fymr">参数名称</td>
<td class="tg-fymr">备注</td>
<td class="tg-fymr">示例</td>
<td class="tg-fymr">可行性</td>
<td class="tg-fymr">可行性描述</td>
<td class="tg-fymr">特别说明</td>
</tr>
<tr>
<td class="tg-0pky">45</td>
<td class="tg-0pky">手机卡国家</td>
<td class="tg-0pky">simCountryIso</td>
<td class="tg-0pky">手机卡国家iso代码</td>
<td class="tg-0pky">cn</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">模拟器获取为NONE</td>
</tr>
<tr>
<td class="tg-0pky">46</td>
<td class="tg-0pky">运营商名字</td>
<td class="tg-0pky">simOperatorName</td>
<td class="tg-0pky">运营商名字</td>
<td class="tg-0pky">中国联通</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">模拟器获取为NONE</td>
</tr>
<tr>
<td class="tg-0pky">47</td>
<td class="tg-0pky">运营商id</td>
<td class="tg-0pky">simOperator</td>
<td class="tg-0pky">运营商id</td>
<td class="tg-0pky">46001</td>
<td class="tg-0pky">Y/N</td>
<td class="tg-0pky">能获取国家代码和网络代码，运营商id，没有直接获取的api</td>
<td class="tg-0pky">模拟器获取为NONE</td>
</tr>
<tr>
<td class="tg-0pky">48</td>
<td class="tg-0pky">手机卡状态</td>
<td class="tg-0pky">simState</td>
<td class="tg-0pky">SIM_STATE_UNKNO</td>
<td class="tg-0pky">UNKNOW、INSTALL、NONE</td>
<td class="tg-0pky">Y/N</td>
<td class="tg-0pky">只能获取到是否插入sim卡</td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">49</td>
<td class="tg-0pky">移动国家代码</td>
<td class="tg-0pky">mobileCountryCode</td>
<td class="tg-0pky">移动国家代码</td>
<td class="tg-0pky">NONE，1</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky" colspan="8"></td>
</tr>
<tr>
<td class="tg-dbbi" colspan="8">（五）screenInfo-屏幕信息</td>
</tr>
<tr>
<td class="tg-fymr">序号</td>
<td class="tg-fymr">屏幕信息名称</td>
<td class="tg-fymr">参数名称</td>
<td class="tg-fymr">备注</td>
<td class="tg-fymr">示例</td>
<td class="tg-fymr">可行性</td>
<td class="tg-fymr">可行性描述</td>
<td class="tg-fymr">特别说明</td>
</tr>
<tr>
<td class="tg-0pky">50</td>
<td class="tg-0pky">屏幕高度</td>
<td class="tg-0pky">screenWidth</td>
<td class="tg-0pky">屏幕高度</td>
<td class="tg-0pky">4.960638</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">51</td>
<td class="tg-0pky">屏幕宽度</td>
<td class="tg-0pky">screenHeight</td>
<td class="tg-0pky">屏幕宽度</td>
<td class="tg-0pky">2.795277</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">52</td>
<td class="tg-0pky">屏幕密度</td>
<td class="tg-0pky">density</td>
<td class="tg-0pky">屏幕密度</td>
<td class="tg-0pky">2</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">53</td>
<td class="tg-0pky">屏幕亮度值</td>
<td class="tg-0pky">screenBrightness</td>
<td class="tg-0pky">屏幕亮度值 0--255</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">模拟器获取为0</td>
</tr>
<tr>
<td class="tg-0pky" colspan="8"></td>
</tr>
<tr>
<td class="tg-dbbi" colspan="8">（六）sensorInfo-传感器信息</td>
</tr>
<tr>
<td class="tg-fymr">序号</td>
<td class="tg-fymr">传感信息名称</td>
<td class="tg-fymr">参数名称</td>
<td class="tg-fymr">备注</td>
<td class="tg-fymr">示例</td>
<td class="tg-fymr">可行性</td>
<td class="tg-fymr">可行性描述</td>
<td class="tg-fymr">特别说明</td>
</tr>
<tr>
<td class="tg-0pky">54</td>
<td class="tg-0pky">定位经度</td>
<td class="tg-0pky">gpsLongitude</td>
<td class="tg-0pky">定位经度</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky">需要用户授权位置权限</td>
<td class="tg-0pky">在没有权限的情况下为NONE</td>
</tr>
<tr>
<td class="tg-0pky">55</td>
<td class="tg-0pky">定位纬度</td>
<td class="tg-0pky">gpsLatitude</td>
<td class="tg-0pky">定位纬度</td>
<td class="tg-0pky"></td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky">需要用户授权位置权限</td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">56</td>
<td class="tg-0pky">GPS认证状态</td>
<td class="tg-0pky">gpsStatus</td>
<td class="tg-0pky">GPS认证状态</td>
<td class="tg-0pky">NotDetermined、Restricted、Denied、Always、WhenInUse、NONE</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">57</td>
<td class="tg-0pky">GPS开关</td>
<td class="tg-0pky">gpsSwitch</td>
<td class="tg-0pky">gps开关是否打开</td>
<td class="tg-0pky">0、1</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky" colspan="8"></td>
</tr>
<tr>
<td class="tg-dbbi" colspan="8">（七）storageInfo-存储/内存信息</td>
</tr>
<tr>
<td class="tg-fymr">序号</td>
<td class="tg-fymr">存储信息名称</td>
<td class="tg-fymr">参数名称</td>
<td class="tg-fymr">备注</td>
<td class="tg-fymr">示例</td>
<td class="tg-fymr">可行性</td>
<td class="tg-fymr">可行性描述</td>
<td class="tg-fymr">特别说明</td>
</tr>
<tr>
<td class="tg-0pky">58</td>
<td class="tg-0pky">内存总大小</td>
<td class="tg-0pky">totalMemory</td>
<td class="tg-0pky">bytes为单位</td>
<td class="tg-0pky">8589934592</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">59</td>
<td class="tg-0pky">内部存储</td>
<td class="tg-0pky">totalSpace</td>
<td class="tg-0pky">bytes为单位</td>
<td class="tg-0pky">501580873728</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">60</td>
<td class="tg-0pky">物理内存当前占用</td>
<td class="tg-0pky">usedMemory</td>
<td class="tg-0pky">bytes为单位</td>
<td class="tg-0pky">14700544</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">61</td>
<td class="tg-0pky">app占用内存</td>
<td class="tg-0pky">appUsedMemory</td>
<td class="tg-0pky">bytes为单位</td>
<td class="tg-0pky">48287744</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
<tr>
<td class="tg-0pky">62</td>
<td class="tg-0pky">空闲的总内存</td>
<td class="tg-0pky">freeSpace</td>
<td class="tg-0pky">bytes为单位</td>
<td class="tg-0pky">18707865600</td>
<td class="tg-0pky">Y</td>
<td class="tg-0pky"></td>
<td class="tg-0pky"></td>
</tr>
</table>

# 接入指南


### 1.接入代码
```
#import "JSAnalysis.h"

[JSAnalysis standardAnalysis].appKey = @"你的AppJKey";
//手动获取
[[JSAnalysis standardAnalysis] getAnalysisBoxWithOption:JSAnalysisGetAnalysisBoxOptionManual responseBlock:^(NSDictionary * _Nonnull analysisBoxInfo) {
    NSLog(@"%@",analysisBoxInfo);
}];

```
更改JSAnalysisGetAnalysisBoxOptionManual 为 JSAnalysisGetAnalysisBoxOptionIntelligentAuto 可以在特定的条件下自动上传到信息收集的服务器，用户可根据 jsBox去查询数据的解密结果。

`- (void)getAnalysisBoxWithOption:(JSAnalysisGetAnalysisBoxOption)option responseBlock:(void(^)(NSDictionary *analysisBoxInfo))block` API 每次被调用都会执行重新获取动作，如果需要重新获取，在每个合适的节点重新调用即可。

提供了设备信息的缓存：`cacheBoxInfo` 在`JSAnalysis`的单例对象中可获取。

** 如果需要不加密的数据可以参考 `JSAnalysis.m` 中的`getAllInfo`方法实现. **

### 成功获取数据示例:
```

{
    // app 标识
    "appBundle" = "com.analysisi.show";
    // 信息加密后的结果
    "jsBox" = "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";
    // 数据签名
    "sign" = 377dce9785fc41c5e502cefa3082531b;
    // 获取时间
    "timestamp" = 1551237554589;
    // 设备标识 IDFA
    clientId = "9047090B-1140-4A66-8503-A76B7698C113";
    // sdk版本
    sdkVersion = "1.0.0";
    // 签名
    sign = 84ec561739fe2ce531e3ce8c8cba427d;
    timestamp = 1552977734417;
}

```

### 2,加解密过程

举例：
两个关键的key

- AES256 key： 0f607264fc6318a92b9e13c65db7cd3c (用于AES256将敏感数据加密) 
- `JSAnalysisEncryptionTool.m` 的 `static const char JSEncryptionToolAES256Key[]  = "xxxxxxxxxxxxxxxx";`修改AES256的密钥
- sign key : appkey_test (用于将加密后的数据做签名，防篡改)
- 签名默认加密私钥使用的是`JSAnalysis.h`中`@property (nonatomic, copy, nonnull) NSString *appKey;` 请自行更改.

### 加密过程：

#### jsBox：
- 一个map，将其中的key：value对，按照key升序排列，如 app、baby、brand、cos、design...
- 使用 AES256 key 以及 AES256加密方式对步骤1中的结果map进行加密。

#### sign：
- map = { app_bundle ： 当前应用标识,
        jsBox ： 加密后的结果值,
        timestamp ：当前时间的时间戳
} (同样按key升序)

- 以sign key为盐 做md5.

#### 解密按照AES256
步骤1中的加密数据解密结果：

```
{
    appInfo = {
        appBundle = "com.ucredit.sales";
        appName = AnalysisDemo;
        appVersion = "1.0.0";
        launchTime = "0.51";
        sdkVersion = "1.0.0";
        userId = NONE;
    };
    clientInfo = {
        IDFA = "9047090B-1140-4A66-8503-A76B7698C113";
        UUID = "2F0CB187-60A6-48EE-8DAE-C8C97FC1B186";
        appCpuUsage = "61.80";
        batteryState = Unknown;
        bootTime = 1552914866;
        brand = Apple;
        charging = 0;
        cpuUsage = "16.50";
        deviceModel = "x86_64";
        deviceName = "iPhone XR";
        dumpEnergy = "-1.00";
        initialLanguage = en;
        jailbroken = NONE;
        kernelVersion = "Darwin Kernel Version 18.2.0: Mon Nov 12 20:24:31 PST 2018; root:xnu-4903.231.4~1/RELEASE_X86_64";
        manufacturer = Apple;
        nowTime = 1552977730;
        osName = iOS;
        osSDK = "12.1";
        osVersion = "12.1";
        simulator = 1;
        timeZone = "Asia/Shanghai (GMT+8d) offset 28800";
        upTime = 62864;
    };
    netInfo = {
        SSID = NONE;
        bluetoothName = "iPhone XR";
        cellIp = NONE;
        mac = NONE; 
        networkType = WiFi;
        proxyIp = NONE;
        radioType = NONE;
        routerAddress = "10.255.16.152";
        routerDstaddr = "10.255.17.255";
        routerGateway = "16.44.60.99";
        routerMac = NONE;
        routerName = "112.50.112.48";
        routerNetmask = "255.255.254.0";
        voipStatus = 0;
        wifiIp = "10.255.16.152";
    };
    phoneCardInfo = {
        mobileCountryCode = NONE;
        simCountryIso = NONE;
        simOperator = NONE;
        simOperatorName = NONE;
        simState = UNKNOW;
    };
    screenInfo = {
        density = 2;
        screenBrightness = 0;
        screenHeight = 480;
        screenWidth = 320;
    };
    sensorInfo = {
        gpsLatitude = "0.000000";
        gpsLongitude = "0.000000";
        gpsStatus = NotDetermined;
        gpsSwitch = 1;
    };
    storageInfo = {
        appUsedMemory = 48046080;
        freeSpace = 12156682240;
        totalMemory = 8589934592;
        totalSpace = 501580873728;
        usedMemory = "-147644416";
    };
}

```

