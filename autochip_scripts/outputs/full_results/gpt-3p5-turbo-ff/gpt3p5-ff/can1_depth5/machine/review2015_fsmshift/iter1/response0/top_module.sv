module top_module(
	input clk,
	input reset,
	output reg shift_ena
	);
    
    reg [2:0] state;
    
    always @(posedge clk) begin
        if(reset) begin
            state <= 3'b000;
        end else begin
            case(state)
                3'b000: begin
                    if(shift_ena) begin
                        state <= 3'b001;
                    end else begin
                        state <= 3'b111;
                    end
                end
                
                3'b001: begin
                    if(shift_ena) begin
                        state <= 3'b010;
                    end else begin
                        state <= 3'b111;
                    end
                end
                
                3'b010: begin
                    if(shift_ena) begin
                        state <= 3'b011;
                    end else begin
                        state <= 3'b111;
                    end
                end
                
                3'b011: begin
                    if(shift_ena) begin
                        state <= 3'b100;
                    end else begin
                        state <= 3'b111;
                    end
                end
                
                default: begin
                    state <= 3'b111;
                end
            endcase
        end
    end
    
    always @(state) begin
        if(reset) begin
            shift_ena <= 1'b0;
        end else if(state != 3'b111) begin
            shift_ena <= 1'b1;
        end else begin
            shift_ena <= 1'b0;
        end
    end
    
endmodule
