package com.ccx.models.util;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * @Description: 均分list
 * @Author: wxn
 * @Date: 2017/11/27 16:19:37
 */
public class ListAverageAssign {

    /**
     * @Description: 将一个list均分成n份,主要通过偏移量来实现的
     * @Author: wxn
     * @Date: 2017/11/27 16:19:07
     */
    public static List<LinkedHashMap<String,Object>> averageAssign(List<LinkedHashMap<String,Object>> source, int n) {
        List<LinkedHashMap<String,Object>> result = new ArrayList<LinkedHashMap<String,Object>>();
        if(source.size()<=n){
            result = source;
        }else{
            int remaider = source.size() % n;  //(先计算出余数)
            int number = source.size() / n;  //然后是商
            int offset = 0;//偏移量
            for (int i = 0; i < n; i++) {
                LinkedHashMap<String,Object> value = new LinkedHashMap<String,Object>();
                if (remaider > 0) {
                    value = source.get(i * number + offset);
                    remaider--;
                    offset++;
                } else {
                    value = source.get(i * number + offset);
                }
                result.add(value);
            }
        }
        //将横坐标转化为0到1之间的数字
        if(null != result && !result.isEmpty()){
            result = averageAssignNum(1,result);
        }
        return result;
    }

    /**
     * @Description: 将横坐标转化为0到1之间的数字
     * @Author: wxn
     * @Date: 2017/11/30 19:16:11
     */
    public static List<LinkedHashMap<String,Object>> averageAssignNum(int max,List<LinkedHashMap<String,Object>> source) {
        BigDecimal res = (new BigDecimal(max)).divide(new BigDecimal(source.size()),3,BigDecimal.ROUND_HALF_UP);
        BigDecimal chushi = new BigDecimal(0);
        for (int i=0;i<source.size();i++){
            source.get(i).put("abscissa",chushi);
            chushi = res.add(chushi);
        }
        return source;
    }

    public static void main(String[] args) {
//        System.err.println(averageAssignNum(1,5));
    }

}
