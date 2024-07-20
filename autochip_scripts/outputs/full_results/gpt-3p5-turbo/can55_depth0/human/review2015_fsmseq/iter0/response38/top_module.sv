module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);
    
    reg [3:0] state;
    parameter START = 2'b00;
    parameter SEARCH = 2'b01;
    parameter FOUND = 2'b10;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= START;
        else begin
            case(state)
                START: begin
                    if (data == 1'b1)
                        state <= SEARCH;
                end
                SEARCH: begin
                    if (data == 1'b1)
                        state <= SEARCH;
                    else if (data == 1'b0)
                        state <= FOUND;
                end
                FOUND: begin
                    state <= FOUND;
                end
            endcase
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            start_shifting <= 1'b0;
        else begin
            if (state == FOUND)
                start_shifting <= 1'b1;
            else
                start_shifting <= 1'b0;
        end
    end
    
endmodule
