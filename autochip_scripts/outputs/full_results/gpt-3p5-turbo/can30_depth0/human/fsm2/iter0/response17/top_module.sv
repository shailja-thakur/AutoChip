module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

// Define the states
parameter OFF = 0;
parameter ON = 1;

// Define the state register
reg [1:0] state;

// Define the output register
reg out_reg;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Asynchronous reset
        state <= OFF;
        out_reg <= 0;
    end else begin
        case (state)
            OFF: begin
                if (j) begin
                    state <= ON;
                    out_reg <= 0;
                end else begin
                    state <= OFF;
                    out_reg <= 0;
                end
            end
            ON: begin
                if (k) begin
                    state <= OFF;
                    out_reg <= 1;
                end else begin
                    state <= ON;
                    out_reg <= 1;
                end
            end
        endcase
    end
end

// Assign the output
assign out = out_reg;

endmodule
