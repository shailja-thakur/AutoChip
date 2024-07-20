module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the state variables
reg [2:0] state;
parameter IDLE = 3'b000, SHIFT = 3'b001, COMPLEMENT = 3'b010, OUTPUT = 3'b011;

// Internal register to hold the input number
reg [7:0] number;
reg [2:0] count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        z <= 0;
        number <= 0;
        count <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= SHIFT;
                    count <= 0;
                end
            end
            SHIFT: begin
                number <= {number[6:0], x};
                count <= count + 1;
                if (count == 7) begin
                    state <= COMPLEMENT;
                end
            end
            COMPLEMENT: begin
                number <= ~number + 1;
                state <= OUTPUT;
            end
            OUTPUT: begin
                z <= number[0];
                number <= {1'b0, number[7:1]};
                if (number == 0) begin
                    state <= IDLE;
                end
                else begin
                    state <= OUTPUT;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
