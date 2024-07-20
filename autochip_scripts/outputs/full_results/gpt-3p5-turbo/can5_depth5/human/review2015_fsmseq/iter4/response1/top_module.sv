module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    reg [3:0] state;
    reg next_state;
    wire match_found;
    
    assign match_found = (state == 4'b1101);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;
            start_shifting <= 0;
        end
        else begin
            state <= next_state;
            case(state)
                4'b0000: next_state = (data) ? 4'b0001 : 4'b0000;
                4'b0001: next_state = (data) ? 4'b0010 : 4'b0000;
                4'b0010: next_state = (data) ? 4'b0011 : 4'b0000;
                4'b0011: next_state = (match_found) ? 4'b0100 : 4'b0000;
                4'b0100: next_state = 4'b0000;
                default: next_state = 4'b0000;
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            start_shifting <= 0;
        end
        else if (match_found) begin
            start_shifting <= 1;
        end
    end
endmodule
