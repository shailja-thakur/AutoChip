module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);
    
    reg [3:0] state;
    reg [3:0] next_state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;
            start_shifting <= 0;
        end else begin
            state <= next_state;
            case (state)
                4'b0000: begin
                    if (data) begin
                        next_state <= 4'b0001;
                    end
                end
                4'b0001: begin
                    if (data) begin
                        next_state <= 4'b0011;
                    end else begin
                        next_state <= 4'b0000;
                    end
                end
                4'b0011: begin
                    if (data) begin
                        next_state <= 4'b0111;
                    end else begin
                        next_state <= 4'b0000;
                    end
                end
                4'b0111: begin
                    if (data) begin
                        next_state <= 4'b1111;
                    end else begin
                        next_state <= 4'b0000;
                    end
                end
                4'b1111: begin
                    if (data) begin
                        next_state <= 4'b1111;
                    end else begin
                        next_state <= 4'b0000;
                        start_shifting <= 1;
                    end
                end
                default: next_state <= 4'b0000;
            endcase
        end
    end
    
endmodule
