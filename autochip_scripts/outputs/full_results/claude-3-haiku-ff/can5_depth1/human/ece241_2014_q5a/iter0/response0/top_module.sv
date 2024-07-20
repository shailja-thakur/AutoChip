module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states of the state machine
parameter [1:0] IDLE = 2'b00, CONVERT = 2'b01, DONE = 2'b11;

// Internal registers
reg [1:0] state;
reg [7:0] num;
reg [3:0] count;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        num <= 0;
        count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= CONVERT;
                end
            end
            CONVERT: begin
                num <= {num[6:0], x}; // Shift in the new bit
                count <= count + 1; // Increment the bit count
                if (count == 7) begin // All 8 bits received
                    state <= DONE;
                end
            end
            DONE: begin
                z <= ~num + 1; // Output the 2's complement
                if (areset) begin
                    state <= IDLE;
                    count <= 0;
                end
            end
        endcase
    end
end

endmodule
