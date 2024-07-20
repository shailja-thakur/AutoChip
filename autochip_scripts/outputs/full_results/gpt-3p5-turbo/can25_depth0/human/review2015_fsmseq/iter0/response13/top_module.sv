module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg next_state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 4'b0000;
        end else begin
            state <= next_state;
        end
    end
    
    always @(state or data) begin
        case(state)
            4'b0000: if (data) begin 
                        next_state = 4'b0001;
                      end else begin
                        next_state = 4'b0000;
                      end
            4'b0001: if (data) begin 
                        next_state = 4'b0011;
                      end else begin
                        next_state = 4'b0000;
                      end
            4'b0011: if (data) begin 
                        next_state = 4'b0110;
                      end else begin
                        next_state = 4'b0000;
                      end
            4'b0110: if (data) begin 
                        next_state = 4'b0101;
                      end else begin
                        next_state = 4'b0000;
                      end
            4'b0101: if (data) begin 
                        next_state = 4'b0001;
                      end else begin
                        next_state = 4'b1101;
                      end
            default: next_state = 4'b0000;
        endcase
    end
    
    always @(posedge clk) begin
        if (reset) begin
            start_shifting <= 1'b0;
        end else begin
            if (state == 4'b1101) begin
                start_shifting <= 1'b1;
            end
        end
    end
    
endmodule
