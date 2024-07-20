module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// Registers
reg [7:0] negative_x;
reg z_reg;
reg areset_reg;

// Combinational logic
wire negative_x_valid;
assign negative_x_valid = |negative_x;

// State machine states
parameter S_IDLE = 2'b00;
parameter S_CONVERT = 2'b01;

// State machine registers
reg [1:0] state;
reg [2:0] count;

// State machine next states
reg [1:0] next_state;
reg [2:0] next_count;

// Output logic
assign z = negative_x_valid ? ~negative_x + 1 : negative_x;

// Synchronous reset
always @(posedge clk) begin
    if (areset) begin
        state <= S_IDLE;
        count <= 3'b0;
    end else begin
        state <= next_state;
        count <= next_count;
    end
end

// Next state and count logic
always @(state, count, negative_x_valid, x) begin
    next_state = state;
    next_count = count;

    case (state)
        S_IDLE: begin
            if (~areset_reg & ~areset) begin
                next_state = S_CONVERT;
                next_count = 3'b1;
            end
        end
        S_CONVERT: begin
            if (count == 3'b111) begin
                next_state = S_IDLE;
                next_count = 3'b0;
            end else if (negative_x_valid) begin
                next_count = count + 1;
            end
        end
    end
end

// Negative_x logic
always @(posedge clk or negedge areset) begin
    if (areset) begin
        negative_x <= 8'b0;
    end else if ((state == S_CONVERT) & (~areset_reg & areset)) begin
        negative_x <= {x, negative_x[7:1]};
    end
end

// Output register
always @(posedge clk or negedge areset) begin
    if (areset) begin
        z_reg <= 8'b0;
    end else if (state == S_CONVERT) begin
        if (count == 3'b111) begin
            z_reg <= negative_x_valid ? ~negative_x + 1 : negative_x;
        end
    end
end

// Asynchronous reset register
always @(posedge clk or negedge areset) begin
    if (areset) begin
        areset_reg <= 1'b1;
    end else begin
        areset_reg <= 1'b0;
    end
end

endmodule
