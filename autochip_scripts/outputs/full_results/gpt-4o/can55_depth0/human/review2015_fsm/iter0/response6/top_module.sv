module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
    );
    
    // State enumeration
    typedef enum reg [3:0] {
        IDLE,
        S1,
        S2,
        S3,
        S4,
        SHIFT,
        COUNT,
        DONE,
        WAIT_ACK
    } state_t;
    
    reg [3:0] state, next_state;
    reg [1:0] shift_count;

    // State transition
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        shift_ena = 0;
        counting = 0;
        done = 0;
        
        case(state)
            IDLE: begin
                if(data == 1'b1) next_state = S1;
            end
            
            S1: begin
                if(data == 1'b1) next_state = S2;
                else next_state = IDLE;
            end
            
            S2: begin
                if(data == 1'b0) next_state = S3;
                else next_state = IDLE;
            end
            
            S3: begin
                if(data == 1'b1) next_state = S4;
                else next_state = IDLE;
            end
            
            S4: begin
                if(data == 1'b1) next_state = SHIFT;
                else next_state = IDLE;
            end
            
            SHIFT: begin
                shift_ena = 1;
                if(shift_count == 2'b11) next_state = COUNT;
                else next_state = SHIFT;
            end
            
            COUNT: begin
                counting = 1;
                if(done_counting) next_state = DONE;
                else next_state = COUNT;
            end
            
            DONE: begin
                done = 1;
                if(ack) next_state = IDLE;
                else next_state = WAIT_ACK;
            end
            
            WAIT_ACK: begin
                done = 1;
                if(ack) next_state = IDLE;
                else next_state = WAIT_ACK;
            end
            
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Counter for shifting
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            shift_count <= 2'b00;
        end
        else if(state == SHIFT) begin
            shift_count <= shift_count + 1;
        end
        else begin
            shift_count <= 2'b00;
        end
    end

endmodule
