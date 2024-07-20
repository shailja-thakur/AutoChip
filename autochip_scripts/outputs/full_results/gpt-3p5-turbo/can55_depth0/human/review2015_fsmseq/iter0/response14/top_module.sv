module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);
    
    reg [3:0] state;
    reg [3:0] next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            start_shifting <= 0;
        end else begin
            state <= next_state;
            start_shifting <= (state == 3'b1101);
        end
    end

    always @(state or data) begin
        case (state)
            4'b0000: next_state = (data == 1'b1) ? 4'b0001 : 4'b0000;
            4'b0001: next_state = (data == 1'b1) ? 4'b0010 : 4'b0000;
            4'b0010: next_state = (data == 1'b0) ? 4'b0011 : 4'b0000;
            4'b0011: next_state = (data == 1'b1) ? 4'b0100 : 4'b0000;
            4'b0100: next_state = (data == 1'b1) ? 4'b0101 : 4'b0000;
            4'b0101: next_state = (data == 1'b0) ? 4'b0110 : 4'b0000;
            4'b0110: next_state = (data == 1'b0) ? 4'b0111 : 4'b0000;
            4'b0111: next_state = (data == 1'b1) ? 4'b1000 : 4'b0000;
            4'b1000: next_state = (data == 1'b1) ? 4'b1001 : 4'b0000;
            4'b1001: next_state = (data == 1'b0) ? 4'b1010 : 4'b0000;
            4'b1010: next_state = (data == 1'b1) ? 4'b1011 : 4'b0000;
            4'b1011: next_state = (data == 1'b0) ? 4'b1100 : 4'b0000;
            4'b1100: next_state = (data == 1'b1) ? 4'b1101 : 4'b0000;
            4'b1101: next_state = 4'b1111;
            default: next_state = 4'b0000;
        endcase
    end
endmodule
