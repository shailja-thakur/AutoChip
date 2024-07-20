module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// Define states
parameter S_INIT = 2'b00;
parameter S_PROCESS = 2'b01;
parameter S_RESET = 2'b10;

reg [1:0] state;
reg [7:0] count;
reg [7:0] sum;
reg z;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= S_RESET;
        count <= 0;
        sum <= 0;
        z <= 0;
    end else begin
        case (state)
            S_INIT: begin
                if (x == 1'b1) begin
                    state <= S_PROCESS;
                    count <= 0;
                    sum <= 0;
                end else begin
                    state <= S_INIT;
                end
            end
            S_PROCESS: begin
                if (x == 1'b1) begin
                    state <= S_PROCESS;
                    count <= count + 1;
                    sum <= sum + (x << count);
                end else begin
                    state <= S_PROCESS;
                    count <= count + 1;
                end
            end
            S_RESET: begin
                if (areset) begin
                    state <= S_INIT;
                end else begin
                    state <= S_RESET;
                end
            end
        endcase
    end
end

assign z = ~sum + 1;

endmodule
