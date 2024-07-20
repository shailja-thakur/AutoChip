module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states
localparam [1:0] WAIT = 2'b00, CONVERT = 2'b01, DONE = 2'b11;
reg [1:0] state, next_state;

// Declare variables
reg [7:0] input_num, complement;
reg [3:0] count;

// Sequential logic (state transitions)
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WAIT;
        input_num <= 0;
        complement <= 0;
        count <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        if (state == CONVERT) begin
            input_num <= {input_num[6:0], x};
            complement <= {complement[6:0], ~x};
            count <= count + 1;
        end
    end
end

// Combinational logic (next state)
always @(*) begin
    case (state)
        WAIT: begin
            if (!areset) next_state = CONVERT;
            else next_state = WAIT;
        end
        CONVERT: begin
            if (count == 7) next_state = DONE;
            else next_state = CONVERT;
        end
        DONE: next_state = WAIT;
        default: next_state = WAIT;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        CONVERT: z = complement[7];
        DONE: z = 1;
        default: z = 0;
    endcase
end

endmodule
