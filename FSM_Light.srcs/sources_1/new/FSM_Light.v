`timescale 1ns / 1ps

module FSM_Light(
    input i_clk,
    input i_reset,
    input i_OnOffSw,

    output o_light
    );

    parameter S_LED_ON  = 1'b0,
              S_LED_OFF = 1'b1;

    reg curState, nextState; // 상태를 가지고 있는 값
    reg r_light;
    assign o_light = r_light;

    // 상태 변경 적용
    // 입력 클럭과 동기화하여 적용
    always @(posedge i_clk or posedge i_reset) begin
        if (i_reset) curState <= S_LED_OFF;
        else         curState <= nextState;
        
    end

    // 이벤트가 발생 할 때 sw, 상태를 봐야함
    // 이벤트 처리 부분
    always @(curState  or i_OnOffSw) begin
        case (curState) //  OFF 상태
            S_LED_OFF : begin
                // 이벤트
                if (i_OnOffSw == 1'b1) nextState <= S_LED_ON;
                else nextState <= S_LED_OFF;
            end
            S_LED_ON  : begin // ON 상태
                if (i_OnOffSw == 1'b0) nextState <= S_LED_OFF;
                else nextState <= S_LED_ON;
            end
        endcase
    end

    // 상태에 따른 동작 부분
    // 현재 상태에 따라 동작하겠다
    always @(curState) begin
        case (curState)
            S_LED_OFF : r_light <= 1'b0;
            S_LED_ON : r_light <= 1'b1;
        endcase
    end
endmodule
