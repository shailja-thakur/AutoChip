module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

    // State encoding
    typedef enum reg [3:0] {
        IDLE  = 4'd0,
        START = 4'd1,
        DATA0 = 4'd2,
        DATA1 = 4'd3,
        DATA2 = 4'd4,
        DATA3 = 4'd5,
        DATA4 = 4'd6,
        DATA5 = 4'd7,
        DATA6 = 4'd8,
        DATA7 = 4'd9,
        STOP  = 4'd10
    } state_t;
    
    state_t state, next_state;
    reg [2:0] bit_counter;
    
    // Sequential logic for state transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 3'd0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state and outputs
    always @(*) begin
        // Default values for next state and done
        next_state = state;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit (0)
                    next_state = START;
            end

            START: begin
                next_state = DATA0; // Move to first data bit
            end

            DATA0: begin
                next_state = DATA1;
            end
            
            DATA1: begin
                next_state = DATA2;
            end
            
            DATA2: begin
                next_state = DATA3;
            end
            
            DATA3: begin
                next_state = DATA4;
            end
            
            DATA4: begin
                next_state = DATA5;
            end
            
            DATA5: begin
                next_state = DATA6;
            end
            
            DATA6: begin
                next_state = DATA7;
            end
            
            DATA7: begin
                next_state = STOP;
            end
            
            STOP: begin
                if (in == 1'b1) begin // Verify stop bit (1)
                    done = 1'b1; // Byte correctly received
                    next_state = IDLE;
                end
                else begin
                    next_state = IDLE; // Wait for stop bit before resetting FSM
                end
            end

            default: next_state = IDLE;
        endcase
    end
endmodule
