module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [2:0] state;
reg x_reg;
reg [1:0] pattern;

// Synchronous reset
always @(posedge clk or negedge aresetn)
begin
    if (aresetn == 0) begin
        state <= 0;
        x_reg <= 0;
        pattern <= 0;
        z <= 0;
    end
    else begin
        // State transition logic
        case(state)
            0: begin
                if (x_reg && !x)
                    state <= 1;
            end
            1: begin
                if (!x_reg && x)
                    state <= 2;
                else if (x_reg && x)
                    state <= 0;
            end
            2: begin
                if (x_reg && x)
                    state <= 2;
                else if (!x_reg && !x)
                    state <= 0;
            end
        endcase

        // Output logic
        if (pattern == 3'b101)
            z <= 1;
        else
            z <= 0;

        // Update registers
        x_reg <= x;
        pattern <= {pattern[0], x_reg};
    end
end
    
endmodule
