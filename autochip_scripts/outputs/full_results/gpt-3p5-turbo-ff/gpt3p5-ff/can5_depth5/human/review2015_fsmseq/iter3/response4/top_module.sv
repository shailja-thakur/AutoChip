module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);
    
    reg [2:0] state;
    reg [2:0] next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            start_shifting <= 0;
        end else begin
            state <= next_state;
        end
    end
    
    always @* begin
        case(state)
            0: begin
                if (data) begin
                    next_state = 1;
                end else begin
                    next_state = 0;
                end
            end
            1: begin
                if (data) begin
                    next_state = 2;
                end else begin
                    next_state = 0;
                end
            end
            2: begin
                if (data) begin
                    next_state = 3;
                end else begin
                    next_state = 0;
                end
            end
            3: begin
                if (data) begin
                    start_shifting <= 1;
                    next_state = 0;
                end else begin
                    next_state = 0;
                end
            end
        endcase
    end

endmodule
