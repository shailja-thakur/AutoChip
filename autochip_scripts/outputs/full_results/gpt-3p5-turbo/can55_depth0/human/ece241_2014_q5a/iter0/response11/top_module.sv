module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// Define state signals
reg [1:0] state;
reg [2:0] reg_x;
reg [2:0] reg_z;

// Define next state logic
always @(posedge clk or negedge areset) begin
    if (areset) begin
        state <= 2'b00; // Initial state
    end else begin
        case (state)
            2'b00: begin
                if (x) begin
                    state <= 2'b01; // Start conversion
                    reg_x <= 3'b000;
                    reg_z <= 3'b000;
                end else begin
                    state <= 2'b00; // Stay in idle state
                end
            end
            2'b01: begin
                if (x) begin
                    state <= 2'b10; // Continue conversion
                    reg_x <= {reg_x[1:0], x};
                end else begin
                    state <= 2'b01; // Stay in conversion state
                    reg_x <= {reg_x[1:0], x};
                end
            end
            2'b10: begin
                if (x) begin
                    state <= 2'b10; // Continue conversion
                    reg_x <= {reg_x[1:0], x};
                end else begin
                    state <= 2'b11; // Finish conversion
                    reg_x <= {reg_x[1:0], x};
                    reg_z <= ~reg_x[2:0] + 1; // Compute 2's complement
                end
            end
            2'b11: begin
                if (areset) begin
                    state <= 2'b00; // Return to idle state
                end else begin
                    state <= 2'b11; // Stay in finish state
                end
            end
        endcase
    end
end

// Assign output
assign z = reg_z[2];

endmodule
