module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state, next_state; // 2-bit register to store current and next state
    parameter B = 2'b00; // state B
    parameter A = 2'b01; // state A
    
    always @(posedge clk or areset) begin
        if (areset) begin
            state <= B; // asynchronously reset to state B if areset is high
        end else begin
            state <= next_state; // update state with next_state on rising edge of clock
        end
    end
    
    always @(state, in) begin // combinational logic to compute next_state and output
        case (state)
            B: begin
                if (in) begin // if input is high
                    next_state = B; // stay in state B
                    out = 1'b1; // output is high
                end else begin // if input is low
                    next_state = A; // transition to state A
                    out = 1'b0; // output is low
                end
            end
            A: begin
                if (in) begin // if input is high
                    next_state = A; // stay in state A
                    out = 1'b0; // output is low
                end else begin // if input is low
                    next_state = B; // transition to state B
                    out = 1'b1; // output is high
                end
            end
            default: begin // if state is not defined
                next_state = B; // transition to state B
                out = 1'b0; // output is low
            end
        endcase
    end
    
endmodule
