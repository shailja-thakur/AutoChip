module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

// Define the state enumeration
localparam OFF = 1'b0, ON = 1'b1;
reg state, next_state;

// State update logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= OFF;
    end
    else begin
        state <= next_state;
    end
end

// Next-state logic
always @(*) begin
    case (state)
        OFF: begin
            if (j) begin
                next_state = ON;
            end
            else begin
                next_state = OFF;
            end
        end
        ON: begin
            if (k) begin
                next_state = OFF;
            end
            else begin
                next_state = ON;
            end
        end
        default: begin
            next_state = OFF;
        end
    endcase
end

// Output logic
always @(*) begin
    case (state)
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
