module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    
    // Define states
    typedef enum logic [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    state_t state, next_state;
    reg [23:0] shift_reg;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) 
            state <= BYTE1;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (state)
            BYTE1: next_state = (in[2] == 1) ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  next_state = (in[2] == 0) ? BYTE1 : DONE;
            default: next_state = BYTE1; // Default state
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 24'b0;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            done <= (state == DONE);
            if(state != DONE) begin
                shift_reg <= {shift_reg[15:0], in};
            end
            if (done)
                out_bytes <= shift_reg;
        end
    end
    
endmodule
