module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

    // State encoding
    typedef enum reg [3:0] {
        IDLE = 4'd0,
        START = 4'd1,
        DATA_0 = 4'd2,
        DATA_1 = 4'd3,
        DATA_2 = 4'd4,
        DATA_3 = 4'd5,
        DATA_4 = 4'd6,
        DATA_5 = 4'd7,
        DATA_6 = 4'd8,
        DATA_7 = 4'd9,
        STOP = 4'd10
    } state_t;
    
    state_t state, next_state;
    reg [7:0] shift_reg;
    reg [3:0] bit_count;
    
    // State transition
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 8'b0;
            bit_count <= 4'd0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic and output logic
    always @ (*) begin
        next_state = state; // Default state is held
        done = 1'b0;
        
        case (state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    next_state = START;
                end
            end
            
            START: begin
                next_state = DATA_0;
            end
            
            DATA_0: begin
                shift_reg[0] = in;
                next_state = DATA_1;
            end
            
            DATA_1: begin
                shift_reg[1] = in;
                next_state = DATA_2;
            end
            
            DATA_2: begin
                shift_reg[2] = in;
                next_state = DATA_3;
            end
            
            DATA_3: begin
                shift_reg[3] = in;
                next_state = DATA_4;
            end
            
            DATA_4: begin
                shift_reg[4] = in;
                next_state = DATA_5;
            end
            
            DATA_5: begin
                shift_reg[5] = in;
                next_state = DATA_6;
            end
            
            DATA_6: begin
                shift_reg[6] = in;
                next_state = DATA_7;
            end
            
            DATA_7: begin
                shift_reg[7] = in;
                next_state = STOP;
            end
            
            STOP: begin
                if (in == 1'b1) begin // Stop bit detected
                    out_byte = shift_reg;
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = IDLE; // Error, waiting for idle line
                end
            end
        endcase
    end
    
endmodule
