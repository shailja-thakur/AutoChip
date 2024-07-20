module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states
localparam STATE_RESET = 2'b00;
localparam STATE_CONVERT = 2'b01;
localparam STATE_DONE = 2'b10;

// Declare state register
reg [1:0] state;

// Declare input and output registers
reg [7:0] input_reg;
wire [7:0] complement;

// Combinational logic for 2's complement
assign complement = ~input_reg + 1;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_RESET;
        z <= 1'b0;
        input_reg <= 8'b0;
    end
    else begin
        case (state)
            STATE_RESET: begin
                z <= 1'b0;
                input_reg <= 8'b0;
                if (~areset) begin
                    state <= STATE_CONVERT;
                end
            end
            STATE_CONVERT: begin
                // Shift the input bit into the input register
                input_reg <= {input_reg[6:0], x};
                // Output the 2's complement of the current input register value
                z <= complement[0];
                if (areset) begin
                    state <= STATE_DONE;
                end
            end
            STATE_DONE: begin
                z <= 1'b0;
            end
            default: begin
                state <= STATE_RESET;
            end
        endcase
    end
end

endmodule
