module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// State definition
typedef enum logic [1:0] {
    IDLE,
    CONVERT
} state_t;

// Define state register and next state logic
reg [1:0] state_reg; // Add width to state register
reg [1:0] state_next; // Add width to next state logic

// Define intermediate signals
reg x_reg;
reg [31:0] z_reg; // Increase width of z_reg to accommodate larger numbers

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        state_reg <= IDLE;
        z_reg <= 0;
    end else begin
        state_reg <= state_next;
        z_reg <= z_reg;
    end
end

always @* begin
    state_next = state_reg;
    case (state_reg)
        IDLE: begin
            if (areset == 1 && x == 1) begin
                state_next = CONVERT;
                z_reg = -x; // Use 2's complement operator instead of subtraction
            end
        end
        CONVERT: begin
            if (x == 1) begin
                z_reg = ~z_reg + 1; // Use z_reg instead of x
                state_next = CONVERT;
            end else begin
                state_next = IDLE;
            end
        end
    endcase
end

always @(posedge clk) begin
    if (areset == 1) begin
        z <= 0;
    end else begin
        z <= z_reg[0]; // Take only the least significant bit of z_reg as output
    end
end

endmodule
