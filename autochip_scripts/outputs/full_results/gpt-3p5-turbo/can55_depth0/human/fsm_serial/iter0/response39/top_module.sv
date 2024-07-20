module top_module (
    input clk,
    input in,
    input reset,
    output done
);
	
    reg [2:0] state;
    reg done_next;
    
    // States
    parameter idle = 3'b000;
    parameter start_bit = 3'b001;
    parameter data_bits = 3'b010;
    parameter stop_bit = 3'b011;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= idle;
            done_next <= 1'b0;
        end else begin
            case (state)
                idle: begin
                    if (in == 1'b0) begin
                        state <= start_bit;
                        done_next <= 1'b0;
                    end else begin
                        state <= idle;
                    end
                end
                start_bit: begin
                    state <= data_bits;
                end
                data_bits: begin
                    if (in == 1'b0) begin
                        state <= data_bits;
                    end else begin
                        state <= stop_bit;
                    end
                end
                stop_bit: begin
                    if (in == 1'b1) begin
                        state <= idle;
                        done_next <= 1'b1;
                    end else begin
                        state <= idle;
                    end
                end
                default: begin
                    state <= idle;
                end
            endcase
        end
    end
    
    assign done = done_next;
	
endmodule
