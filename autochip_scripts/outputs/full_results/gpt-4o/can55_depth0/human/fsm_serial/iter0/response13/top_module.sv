module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

    // State declarations
    typedef enum reg [3:0] {
        IDLE     = 4'b0000,
        START    = 4'b0001,
        DATA0    = 4'b0010,
        DATA1    = 4'b0011,
        DATA2    = 4'b0100,
        DATA3    = 4'b0101,
        DATA4    = 4'b0110,
        DATA5    = 4'b0111,
        DATA6    = 4'b1000,
        DATA7    = 4'b1001,
        STOP     = 4'b1010,
        ERROR    = 4'b1011
    } state_t;

    reg [3:0] current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            IDLE:   next_state = (in == 0) ? START : IDLE;
            START:  next_state = DATA0;
            DATA0:  next_state = DATA1;
            DATA1:  next_state = DATA2;
            DATA2:  next_state = DATA3;
            DATA3:  next_state = DATA4;
            DATA4:  next_state = DATA5;
            DATA5:  next_state = DATA6;
            DATA6:  next_state = DATA7;
            DATA7:  next_state = (in == 1) ? STOP : ERROR;
            STOP:   next_state = IDLE;
            ERROR:  next_state = (in == 1) ? IDLE : ERROR;
            default: next_state = IDLE;
        endcase
    end
    
    // State flip-flops with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end
    
    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 0;
        end else begin
            if (current_state == STOP) begin
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end

endmodule
