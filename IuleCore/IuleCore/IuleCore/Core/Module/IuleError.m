//
//  IuleError.m
//  BoringSSL-GRPC
//
//  Created by mac on 2019/12/10.
//

#import "IuleError.h"

@implementation IuleError

/*
 SUCCESS(1, “成功!”),
 SYSTEM_ERROR(-20000, “系统错误”),
 SQL_ERROR(-20001, “数据库错误”),
 WECHAT_WITHDRAW_ERROR(-20002, “微信提现错误”),
 HAS_NO_AUTH(-20003, “没有权限”),
 HAS_NO_USER(-20004, “用户不存在”),
 LOGOUT(-20005, “登录信息已过期”),
 ILLEGAL_USER(-20007, “非法用户”),
 WITHDRAWING(-20008, “正在提现中”),
 USER_IS_EXIST(-20009, “用户信息已存在”),
 HAS_NO_DATA(-20010, “数据不存在”),
 TOO_LARGE_AMOUNT(-20011, “余额小于提现金额”),
 TOO_LOW_AMOUNT(-20012, “提现金额不可小于1元”),
 NOT_NEW_WITHDRAW(-20013, “一元提现仅限新人”),
 HAS_NO_OPENID(-20014, “无此微信用户”),
 OVER_NUM(-20015, “提现失败，提现次数超过今日可提现次数”),
 OVER_WITHDRAW(-20016, “提现失败，提现金额超过今日可提现总额”),
 RED_PACK_NOT_EXIT(-20017, “红包不存在”),
 RED_PACK_NOT_ON_TIME(-20018, “红包未到开启时间”),
 SHARE_FAIL(-20019, “分享失败”),
 BIGGER_THAN_BALANCE(-20020, “U币使用不能小于余额”),
 HAS_SIGN_IN(-20021, “用户今天已签到”),
 ILLEGAL_TEL(-20022, “手机号非法”),
 HAS_SAME_TEL(-20023, “该号码已注册”),
 EMPTY_TEL(-20024, “手机号不能为空”),
 ILLEGAL_SMS_TYPE(-20025, “短信类型错误”),
 SMS_FAIL(-20026, “短信发送失败”),
 ILLEGAL_PARAMETER(-20027, “参数非法”),
 USELESS_CODE(-20028, “无有效验证码，请重新发送”),
 WRONG_CODE(-20029, “验证码错误，请重新输入”),
 UCOIN_LE_ZERO(-20030, “U币添加不能小于零”),
 WECHAT_NOT_BIND(-20031, “微信号未绑定银行卡”),
 WITHDRAW_FAIL(-20032, “提现失败”),
 HAS_NO_PRIZE(-20033, “奖品不存在”),
 HAS_NO_PRIZE_LIST(-20034, “请初始化奖池”),
 HAS_NOT_ENOUGH_ENERGY(-20035, “没有足够的能量”),
 OVER_TIME(-20036, “今日超过抽奖次数”),
 CONDITION_NOT_SATISFACTION(-20037, “U币余额与积分余额不满足条件”),
 HAS_RECEIVED(-20038, “今日领取超过三次”),
 HAS_NOT_ENOUGH_INTEGRAL(-20039, “积分不够”),
 HAS_NOT_ENOUGH_DRAW_TIME(-20040, “抽奖次数不够”),
 BETTING(-20041, “用户投注中”),
 RED_PACK_VIDEO_NOT_EXIT(-20042, “红包广告不存在”),
 NOT_ENOUGH_UCOIN(-20043, “U币不足无法进行游戏”),
 NOT_HAVE_LACK(-20044, “没有缺卡记录”),
 HAS_NOT_ENOUGH_PRIZE(-20045, “奖品不足”),
 HAS_WITHDRAW(-20046, “用户已享受新人提现”),
 HAS_GUIDE(-20047, “用户已享受新人引导优惠”),
 HAS_NOT_ENOUGH_STAR(-20048, “星星数不够”),
 OVER_STAR(-20049, “超过游戏内星星”),
 WRONG_SCORE(-20050, “提交分数错误”),
 User_Not_Login(-20051, “用户未登陆”),
 User_Kick_Offline(-20052, “用户被挤掉线”),
 Token_Error(-20053, “客户端token错误”),
 COIN_NOT_ENOUGH(-20054, “金币数不足”),
 OVER_DRAW(-20055, “达到抽奖上限”),
 HAVE_NOT_VIDEO(-20056, “未观看视频”),
 HAVE_DOUBLE(-20057, “已翻倍”),
 No_Rank_Reward(-20058, “没有排行榜奖励”),
 WRONG_DATA(-20059, “数据错误”),
 HAS_GET_REWARD(-20060, “用户已领取过奖励”),
 CAN_NOT_GET_REWARD(-20061, “任务尚未达成”),
 */

+ (instancetype)errorWithCode:(NSInteger)code errorInfo:(NSDictionary *)errorInfo {
    return [IuleError errorWithCode:code errorInfo:errorInfo api:@""];
}

+ (instancetype)errorWithCode:(NSInteger)code errorInfo:(NSDictionary *)errorInfo api:(NSString *)api {
    IuleError *error = [[IuleError alloc] init];
    error.code = code;
    error.errorInfo = errorInfo;
    error.api = api;
    NSString *errorMessage = @"";
    switch (code) {
        case -20000:
        {
            errorMessage = @"系统错误";
        }
            break;
        case -20001:
        {
            errorMessage = @"数据库错误";
        }
            break;
        case -20002:
        {
            errorMessage = @"微信提现错误";
        }
            break;
        case -20003:
        {
            errorMessage = @"没有权限";
        }
            break;
        case -20004:
        {
            errorMessage = @"用户不存在";
        }
            break;
        case -20005:
        {
            errorMessage = @"登录信息已过期";
        }
            break;
        case -20007:
        {
            errorMessage = @"非法用户";
        }
            break;
        case -20008:
        {
            errorMessage = @"正在提现中";
        }
            break;
        case -20009:
        {
            errorMessage = @"用户信息已存在";
        }
            break;
        case -20010:
        {
            errorMessage = @"数据不存在";
        }
            break;
        case -20011:
        {
            errorMessage = @"余额小于提现金额";
        }
            break;
        case -20012:
        {
            errorMessage = @"提现金额不可小于1元";
        }
            break;
        case -20013:
        {
            errorMessage = @"一元提现仅限新人";
        }
            break;
        case -20014:
        {
            errorMessage = @"无此微信用户";
        }
            break;
        case -20015:
        {
            errorMessage = @"提现失败，提现次数超过今日可提现次数";
        }
            break;
        case -20016:
        {
            errorMessage = @"提现失败，提现金额超过今日可提现总额";
        }
            break;
        case -20017:
        {
            errorMessage = @"红包不存在";
        }
            break;
        case -20018:
        {
            errorMessage = @"红包未到开启时间";
        }
            break;
        case -20019:
        {
            errorMessage = @"分享失败";
        }
            break;
        case -20020:
        {
            errorMessage = @"U币使用不能小于余额";
        }
            break;
        case -20021:
        {
            errorMessage = @"用户今天已签到";
        }
            break;
        case -20022:
        {
            errorMessage = @"手机号非法";
        }
            break;
        case -20023:
        {
            errorMessage = @"该号码已注册";
        }
            break;
        case -20024:
        {
            errorMessage = @"手机号不能为空";
        }
            break;
        case -20025:
        {
            errorMessage = @"短信类型错误";
        }
            break;
        case -20026:
        {
            errorMessage = @"短信发送失败";
        }
            break;
        case -20027:
        {
            errorMessage = @"参数非法";
        }
            break;
        case -20028:
        {
            errorMessage = @"无有效验证码，请重新发送";
        }
            break;
        case -20029:
        {
            errorMessage = @"验证码错误，请重新输入";
        }
            break;
        case -20030:
        {
            errorMessage = @"U币添加不能小于零";
        }
            break;
        case -20031:
        {
            errorMessage = @"微信号未绑定银行卡";
        }
            break;
        case -20032:
        {
            errorMessage = @"提现失败";
        }
            break;
        case -20033:
        {
            errorMessage = @"奖品不存在";
        }
            break;
        case -20034:
        {
            errorMessage = @"请初始化奖池";
        }
            break;
        case -20035:
        {
            errorMessage = @"没有足够的能量";
        }
            break;
        case -20036:
        {
            errorMessage = @"今日超过抽奖次数";
        }
            break;
        case -20037:
        {
            errorMessage = @"U币余额与积分余额不满足条件";
        }
            break;
        case -20038:
        {
            errorMessage = @"今日领取超过三次";
        }
            break;
        case -20039:
        {
            errorMessage = @"积分不够";
        }
            break;
        case -20040:
        {
            errorMessage = @"抽奖次数不够";
        }
            break;
        case -20041:
        {
            errorMessage = @"用户投注中";
        }
            break;
        case -20042:
        {
            errorMessage = @"红包广告不存在";
        }
            break;
        case -20043:
        {
            errorMessage = @"U币不足无法进行游戏";
        }
            break;
        case -20044:
        {
            errorMessage = @"没有缺卡记录";
        }
            break;
        case -20045:
        {
            errorMessage = @"奖品不足";
        }
            break;
        case -20046:
        {
            errorMessage = @"用户已享受新人提现";
        }
            break;
        case -20047:
        {
            errorMessage = @"用户已享受新人引导优惠";
        }
            break;
        case -20048:
        {
            errorMessage = @"星星数不够";
        }
            break;
        case -20049:
        {
            errorMessage = @"超过游戏内星星";
        }
            break;
        case -20050:
        {
            errorMessage = @"提交分数错误";
        }
            break;
        case -20051:
        {
            errorMessage = @"用户未登陆";
        }
            break;
        case -20052:
        {
            errorMessage = @"用户被挤掉线";
        }
            break;
        case -20053:
        {
            errorMessage = @"客户端token错误";
        }
            break;
        case -20054:
        {
            errorMessage = @"金币数不足";
        }
            break;
        case -20055:
        {
            errorMessage = @"达到抽奖上限";
        }
            break;
        case -20056:
        {
            errorMessage = @"未观看视频";
        }
            break;
        case -20057:
        {
            errorMessage = @"已翻倍";
        }
            break;
        case -20058:
        {
            errorMessage = @"没有排行榜奖励";
        }
            break;
        case -20059:
        {
            errorMessage = @"数据错误";
        }
            break;
        case -20060:
        {
            errorMessage = @"用户已领取过奖励";
        }
            break;
        case -20061:
        {
            errorMessage = @"任务尚未达成";
        }
            break;
            
        default:
            break;
    }
    error.errorMessage = errorMessage;
    return error;
}

@end
