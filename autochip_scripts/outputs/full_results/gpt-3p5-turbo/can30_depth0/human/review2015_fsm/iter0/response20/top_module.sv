module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );
    
    // State definition
    reg [2:0] state;
    
    // State machine
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            state <= 3'b000;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end
        else begin
            case(state)
                3'b000: begin // Waiting for start sequence (1101)
                    if(data == 4'b1101)
                        state <= 3'b001;
                    else
                        state <= 3'b000;
                    
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 0;
                end
                
                3'b001: begin // Assert shift_ena for 4 clock cycles
                    state <= 3'b010;
                    
                    shift_ena <= 1;
                    counting <= 0;
                    done <= 0;
                end
                
                3'b010: begin // Wait for shift_ena to be de-asserted
                    if(shift_ena)
                        state <= 3'b010;
                    else
                        state <= 3'b011;
                    
                    counting <= 0;
                    done <= 0;
                end
                
                3'b011: begin // Assert counting output and wait for done_counting to be high
                    if(done_counting)
                        state <= 3'b100;
                    else
                        state <= 3'b011;
                    
                    shift_ena <= 0;
                    counting <= 1;
                    done <= 0;
                end
                
                3'b100: begin // Assert done and wait for ack to be high
                    if(ack)
                        state <= 3'b000;
                    else
                        state <= 3'b100;
                    
                    shift_ena <= 0;
                    counting <= 0;
                    done <= 1;
                end
            endcase
        end
    end
endmodule
