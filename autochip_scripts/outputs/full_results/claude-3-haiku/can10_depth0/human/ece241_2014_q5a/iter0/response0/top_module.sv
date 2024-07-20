module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states
localparam S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
reg [1:0] state, next_state;

// Register to store the input bits
reg [15:0] input_reg;
reg [15:0] complement;
integer i;

always @(posedge clk, negedge areset) begin
    if (~areset) begin
        state <= S0;
        input_reg <= 0;
        complement <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        input_reg <= {input_reg[14:0], x};
        if (state == S1) begin
            for (i = 0; i < 16; i = i + 1) begin
                complement[i] = ~input_reg[i];
            end
            complement = complement + 1;
            z <= complement[0];
        end
    end
end

// Next state logic
always @(*) begin
    case (state)
        S0: begin
            if (x == 1'b0) begin
                next_state = S0;
            end
            else begin
                next_state = S1;
            end
        end
        S1: begin
            next_state = S2;
        end
        S2: begin
            if (x == 1'b0) begin
                next_state = S2;
            end
            else begin
                next_state = S1;
            end
        end
        default: begin
            next_state = S0;
        end
    endcase
end

endmodule
