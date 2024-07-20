module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// Define state enumeration
typedef enum logic [2:0] {
    IDLE,
    WAIT_START_BIT,
    RECEIVE_DATA_BITS,
    VERIFY_STOP_BIT
} state_type;

// Define state register and next state logic
reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

// Define output register and next output logic
reg [7:0] out_byte_reg;

always @(state) begin
    case (state)
        IDLE: begin
            done = 0;
            out_byte_reg = 0;
        end
        
        WAIT_START_BIT: begin
            done = 0;
            out_byte_reg = 0;
        end
        
        RECEIVE_DATA_BITS: begin
            done = 0;
            out_byte_reg = {out_byte_reg[6:0], in};
        end
        
        VERIFY_STOP_BIT: begin
            done = 0;
            out_byte = out_byte_reg;
            out_byte_reg = 0;
        end
    endcase
end

// Define next state and next output logic
always @(state, in) begin
    next_state = state;
    
    case (state)
        IDLE: begin
            if (in == 0)
                next_state = WAIT_START_BIT;
            done = 0;
        end
        
        WAIT_START_BIT: begin
            if (in == 0)
                next_state = RECEIVE_DATA_BITS;
            done = 0;
        end
        
        RECEIVE_DATA_BITS: begin
            if (in == 0)
                next_state = RECEIVE_DATA_BITS;
            else
                next_state = VERIFY_STOP_BIT;
            done = 0;
        end
        
        VERIFY_STOP_BIT: begin
            if (in == 1)
                next_state = IDLE;
            done = 1;
        end
    endcase
end

endmodule
