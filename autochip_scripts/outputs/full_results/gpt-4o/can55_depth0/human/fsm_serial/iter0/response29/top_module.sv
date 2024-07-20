module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);
    // FSM states
    typedef enum reg [3:0] {
        IDLE,
        START,
        DATA0,
        DATA1,
        DATA2,
        DATA3,
        DATA4,
        DATA5,
        DATA6,
        DATA7,
        STOP,
        ERROR
    } state_t;
    
    state_t state, next_state;
    reg [2:0] data_count;

    // State transition logic
    always @(*) begin
        case (state)
            IDLE:   next_state = (in == 1'b0) ? START : IDLE; // Start bit found
            START:  next_state = DATA0;
            DATA0:  next_state = DATA1;
            DATA1:  next_state = DATA2;
            DATA2:  next_state = DATA3;
            DATA3:  next_state = DATA4;
            DATA4:  next_state = DATA5;
            DATA5:  next_state = DATA6;
            DATA6:  next_state = DATA7;
            DATA7:  next_state = STOP;
            STOP:   next_state = (in == 1'b1) ? IDLE : ERROR; // Stop bit must be 1
            ERROR:  next_state = (in == 1'b1) ? IDLE : ERROR; // Wait for idle line (1)
            default: next_state = IDLE;
        endcase
    end

    // State update logic (sequential portion)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            done <= 1'b0;
            data_count <= 3'd0;
        end else begin
            state <= next_state;
            
            if (next_state == DATA0 || next_state == DATA1 || next_state == DATA2 ||
                next_state == DATA3 || next_state == DATA4 || next_state == DATA5 ||
                next_state == DATA6 || next_state == DATA7) begin
                data_count <= data_count + 1;
            end else begin
                data_count <= 3'd0;
            end

            if (next_state == STOP && state == DATA7 && in == 1'b1) begin
                done <= 1'b1;  // Successfully received a byte
            end else begin
                done <= 1'b0;
            end
        end
    end
endmodule
