module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);
    
    // Define the states
    parameter OFF = 1'b0;
    parameter ON = 1'b1;

    // Define the state register
    reg next_state, current_state;

    // Define the output register
    reg next_out, current_out;

    // Asynchronous reset to state OFF
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= OFF;
            current_out <= 1'b0;
        end else begin
            current_state <= next_state;
            current_out <= next_out;
        end
    end
    
    // Next state logic
    always @(current_state, j, k) begin
        case (current_state)
            OFF: begin
                if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
                next_out = 1'b0;
            end
            ON: begin
                if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
                next_out = 1'b1;
            end
            default: begin
                next_state = OFF;
                next_out = 1'b0;
            end
        endcase
    end

    // Assign the output
    assign out = current_out;

endmodule
