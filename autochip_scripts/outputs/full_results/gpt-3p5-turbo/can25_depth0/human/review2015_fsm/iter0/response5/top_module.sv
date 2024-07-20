module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // state register
    reg [2:0] state;
    
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            // state machine transitions
            case (state)
                3'b000: begin
                    if (data == 4'b1101) begin
                        state <= 3'b001;
                    end
                end
                
                3'b001: begin
                    state <= 3'b010;
                end
                
                3'b010: begin
                    state <= 3'b011;
                end
                
                3'b011: begin
                    state <= 3'b100;
                end
                
                3'b100: begin
                    if (done_counting) begin
                        state <= 3'b101;
                    end
                end
                
                3'b101: begin
                    if (ack) begin
                        state <= 3'b000;
                    end
                end
            endcase
        end
    end
    
    // state machine outputs
    always @(state) begin
        case (state)
            3'b000: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b0;
            end
            
            3'b001: begin
                shift_ena <= 1'b1;
                counting <= 1'b0;
                done <= 1'b0;
            end
            
            3'b010: begin
                shift_ena <= 1'b1;
                counting <= 1'b0;
                done <= 1'b0;
            end
            
            3'b011: begin
                shift_ena <= 1'b1;
                counting <= 1'b0;
                done <= 1'b0;
            end
            
            3'b100: begin
                shift_ena <= 1'b0;
                counting <= 1'b1;
                done <= 1'b0;
            end
            
            3'b101: begin
                shift_ena <= 1'b0;
                counting <= 1'b0;
                done <= 1'b1;
            end
        endcase
    end

endmodule
