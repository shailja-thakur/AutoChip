module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

// Define the states
parameter OFF = 1'b0;
parameter ON = 1'b1;

// Define the current and next states
reg state_c, state_n;

// Update the current state on clock
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state_c <= OFF;
    end
    else begin
        state_c <= state_n;
    end
end

// Combinational logic to update the next state
always @(*) begin
    case (state_c)
        OFF: begin
            if (j) begin
                state_n = ON;
            end
            else begin
                state_n = OFF;
            end
        end
        ON: begin
            if (k) begin
                state_n = OFF;
            end
            else begin
                state_n = ON;
            end
        end
        default: begin
            state_n = OFF;
        end
    endcase
end

// Combinational logic to set the output
always @(*) begin
    case (state_c)
        OFF: begin
            out = 1'b0;
        end
        ON: begin
            out = 1'b1;
        end
        default: begin
            out = 1'b0;
        end
    endcase
end

endmodule
