module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

// Define state enumeration
typedef enum logic [2:0] {IDLE, START, RECEIVE, VERIFY} state_t;

// Define state and flip-flops
state_t state, next_state;
reg [7:0] data_byte;
reg [2:0] count;

// Assign next state and outputs
always_comb begin
    case (state)
        IDLE:   begin
                    if (in == 1'b0)
                        next_state = START;
                    else
                        next_state = IDLE;
                end
        START:  next_state = RECEIVE;
        RECEIVE: if (count == 8)
                    next_state = VERIFY;
                 else
                    next_state = RECEIVE;
        VERIFY: begin
                    if (count == 8 && in == 1'b1)
                        next_state = IDLE;
                    else
                        next_state = RECEIVE;
                end
    endcase
    
    done = (state == VERIFY && count == 8 && in == 1'b1);
end

// Assign current state and outputs
always_ff @(posedge clk, posedge reset) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
    
    case (state)
        IDLE:   begin
                    count <= 0;
                    out_byte <= 8'b0;
                end
        START:  begin
                    count <= 1;
                    out_byte <= 8'b0;
                end
        RECEIVE:count <= count + 1;
        VERIFY: count <= count;
    endcase
end

endmodule
