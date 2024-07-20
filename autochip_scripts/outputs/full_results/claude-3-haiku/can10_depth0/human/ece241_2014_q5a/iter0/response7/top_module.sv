module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states
localparam [1:0] IDLE = 2'b00, 
                 COMP = 2'b01,
                 DONE = 2'b11;

// Internal variables
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
                if (~areset) begin
                    state <= COMP;
                    count <= 0;
                end
            end
            COMP: begin
                num[count] <= x;
                count <= count + 1;
                if (count == 7) begin
                    num <= ~num + 1;
                    state <= DONE;
                end
            end
            DONE: begin
                z <= num[count];
                count <= count - 1;
                if (count == 0) begin
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
