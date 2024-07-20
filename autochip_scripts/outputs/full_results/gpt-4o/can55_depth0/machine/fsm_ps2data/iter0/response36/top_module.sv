module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;
    
    state_t state, next_state;
    
    // Register to store byte inputs
    reg [23:0] out_bytes_reg;

    // State machine - next state logic
    always @(*) begin
        case (state)
            BYTE1: begin
                if (in[2] == 1)
                    next_state = BYTE2;
                else
                    next_state = BYTE1;
            end
            
            BYTE2: next_state = BYTE3;
            
            BYTE3: next_state = DONE;
            
            DONE: begin
                if (in[2] == 0)
                    next_state = BYTE1;
                else
                    next_state = DONE;
            end
            
            default: next_state = BYTE1;
        endcase
    end

    // State machine - state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= BYTE1;
        else
            state <= next_state;
    end

    // Register update logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            out_bytes_reg <= 24'b0;
        else if (state != DONE) begin
            out_bytes_reg <= {out_bytes_reg[15:0], in};
        end
    end
    
    // Output logic
    always @(posedge clk) begin
        if (state == DONE)
            out_bytes <= out_bytes_reg;
        else
            out_bytes <= 24'b0;
            
        if (state == DONE)
            done <= 1;
        else
            done <= 0;
    end

endmodule
