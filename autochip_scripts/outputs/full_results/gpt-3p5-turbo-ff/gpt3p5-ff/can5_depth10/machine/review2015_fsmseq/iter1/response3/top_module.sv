module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
   
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 4'b0;
        else begin
            case(state)
                4'b0000: if (data) state <= 4'b0001; else state <= 4'b0000;
                4'b0001: if (data) state <= 4'b0011; else state <= 4'b0000;
                4'b0011: if (data) state <= 4'b0011; else state <= 4'b0110;
                4'b0110: if (data) state <= 4'b1111; else state <= 4'b0000;
                default: state <= 4'b1111;
            endcase
        end
    end

    always @(state) begin
        start_shifting = (state == 4'b1111) ? 1'b1 : 1'b0;
    end
   
endmodule
