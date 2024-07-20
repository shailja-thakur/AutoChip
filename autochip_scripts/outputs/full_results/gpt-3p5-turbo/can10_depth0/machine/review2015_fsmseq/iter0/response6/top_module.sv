module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    reg [3:0] state;
    
    always @(posedge clk, posedge reset)
    begin
        if (reset)
            state <= 4'b0000;  // initial state S
        else
            case (state)
                4'b0000:  // S
                    begin
                        if (data)
                            state <= 4'b0001;  // next state S1
                        else
                            state <= 4'b0000;  // next state S
                    end
                4'b0001:  // S1
                    begin
                        if (data)
                            state <= 4'b0011;  // next state S11
                        else
                            state <= 4'b0000;  // next state S
                    end
                4'b0011:  // S11
                    begin
                        if (data)
                            state <= 4'b0011;  // next state S11
                        else
                            state <= 4'b0110;  // next state S110
                    end
                4'b0110:  // S110
                    begin
                        if (data)
                            state <= 4'b1111;  // next state Done
                        else
                            state <= 4'b0000;  // next state S
                    end
                4'b1111:  // Done
                    state <= 4'b1111;  // next state Done
            endcase
    end
    
    always @(state)
    begin
        if (state == 4'b1111)  // Done state
            start_shifting <= 1'b1;
        else
            start_shifting <= 1'b0;
    end
    
endmodule
