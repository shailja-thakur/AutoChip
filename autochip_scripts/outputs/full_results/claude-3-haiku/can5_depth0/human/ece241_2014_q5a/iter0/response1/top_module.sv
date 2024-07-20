module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] reg_value; // 8-bit register to store the input value
reg [2:0] state; // 3-bit state register

// State definitions
localparam [2:0] IDLE = 3'b000;
localparam [2:0] COMP = 3'b001;
localparam [2:0] DONE = 3'b010;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        reg_value <= 8'b0;
        z <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (~areset) begin
                    state <= COMP;
                end
            end
            COMP: begin
                reg_value[0] <= x;
                reg_value <= {1'b0, reg_value[7:1]}; // Shift the input value one bit to the right
                z <= ~reg_value[0]; // Output the 2's complement of the current bit
                if (&reg_value) begin // All bits have been processed
                    state <= DONE;
                end
            end
            DONE: begin
                z <= 1'b0; // Hold the output at 0 after the conversion is complete
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
