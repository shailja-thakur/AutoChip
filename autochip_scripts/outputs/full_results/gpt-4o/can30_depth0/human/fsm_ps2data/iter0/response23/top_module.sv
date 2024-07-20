module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    // FSM state definitions
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [23:0] message_reg;  // Register to hold the 3-byte message
    
    // FSM state transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // FSM next state logic and output logic
    always_comb begin
        // Default values
        done = 1'b0;
        next_state = state;
        
        // FSM transition and output logic
        case (state)
            IDLE: begin
                if (in[3]) begin
                    message_reg[23:16] = in;
                    next_state = BYTE1;
                end
            end
            
            BYTE1: begin
                message_reg[15:8] = in;
                next_state = BYTE2;
            end
            
            BYTE2: begin
                message_reg[7:0] = in;
                next_state = BYTE3;
            end
            
            BYTE3: begin
                done = 1'b1;
                out_bytes = message_reg;
                next_state = IDLE;
            end
        endcase
    end
    
    // Message register update
    always_ff @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
            message_reg <= 24'b0;
        end else if (state == BYTE3) begin
            out_bytes <= message_reg;
        end
    end
endmodule
