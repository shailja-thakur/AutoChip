module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [2:0] state;

always @(posedge clk) begin
    if (reset)
        state <= 3'b000;     // reset to initial state (S)
    else begin
        case(state)
            3'b000: begin     // state S
                if (data)
                    state <= 3'b001;     // next state S1
                else
                    state <= 3'b000;     // next state S
            end
            3'b001: begin     // state S1
                if (data)
                    state <= 3'b011;     // next state S11
                else
                    state <= 3'b000;     // next state S
            end
            3'b011: begin     // state S11
                if (data)
                    state <= 3'b011;     // next state S11
                else
                    state <= 3'b110;     // next state S110
            end
            3'b110: begin     // state S110
                if (data)
                    state <= 3'b111;     // next state Done
                else
                    state <= 3'b000;     // next state S
            end
            3'b111: begin     // state Done
                state <= 3'b111;     // next state Done
            end
        endcase
    end
end

always @(state) begin
    if (state == 3'b111)     // if state is Done
        start_shifting <= 1'b1;     // output is high
    else
        start_shifting <= 1'b0;     // output is low
end

endmodule
