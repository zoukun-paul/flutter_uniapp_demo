package com.iks.flutter_uniapp_demo.location;


import com.baidu.location.Address;
import com.baidu.location.BDLocation;
import java.util.Date;

import lombok.Data;

@Data
public class LocationEntity {

    public Double latitude;

    public Double longitude;

    public Date createTime;

    /**
     * 定位类型 {@link BDLocation#getLocType()}
     * 61  gnss 定位
     * 161 网络定位
     * 66  离线定位
     */
    public Integer locType;

    /**
     * gnss 质量
     * {@link BDLocation#GNSS_ACCURACY_GOOD}     1
     * {@link BDLocation#GNSS_ACCURACY_MID}      2
     * {@link BDLocation#GNSS_ACCURACY_BAD}      3
     * {@link BDLocation#GNSS_ACCURACY_UNKNOWN}  4
     */
    public Integer gnssAccuracy;

    /**
     * gnss 定位来源
     * {@link BDLocation#BDLOCATION_GNSS_PROVIDER_FROM_SYSTEM} 系统定位
     * {@link BDLocation#BDLOCATION_GNSS_PROVIDER_FROM_BAIDU_BEIDOU} 北斗单位
     */
    public String gnssProvider;

    /**
     * 网络 定位来源
     * wf：     wifi 定位
     * cl:     cell
     * ll:     satellite
     */
    public String networkLocationType;

    /**
     * 定位精度
     */
    public Float radius;

    /**
     * gnss 定位时的卫星个数
     */
    public Integer satelliteNumber;

    /**
     * 速度 （gnss 定位时才有该值）
     */
    public Float speed;

    /**
     * 坐标类型
     */
    public String coorType;

    /**
     * 设备朝向
     */
    public Float direction;

    /**
     * 位置
     */
    public Address address;

    public LocationEntity(Double latitude, Double longitude) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.createTime = new Date();
    }

    public LocationEntity(Double latitude, Double longitude, Integer locType) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.createTime = new Date();
        this.locType = locType;
    }

    public LocationEntity(BDLocation bdLocation) {
        this.latitude = bdLocation.getLatitude();
        this.longitude = bdLocation.getLongitude();
        this.createTime = new Date();
        this.locType = bdLocation.getLocType();
        this.gnssAccuracy = bdLocation.getGnssAccuracyStatus();
        this.gnssProvider = bdLocation.getGnssProvider();
        this.networkLocationType = bdLocation.getNetworkLocationType();
        this.radius = bdLocation.getRadius();
        this.satelliteNumber = bdLocation.getSatelliteNumber();
        this.speed = bdLocation.getSpeed();
        this.coorType = bdLocation.getCoorType();
        this.direction = bdLocation.getDirection();
        this.address = bdLocation.getAddress();
    }

    public LocationEntity() {
    }

}
