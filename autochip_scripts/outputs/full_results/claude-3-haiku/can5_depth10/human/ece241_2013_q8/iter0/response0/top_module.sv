module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define the state variables
reg [1:0] state;
parameter IDLE = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= IDLE;
        z <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (x == 1'b1) begin
                    state <= S1;
                    z <= 1'b0;
                end
                else begin
                    state <= IDLE;
                    z <= 1'b0;
                end
            end
            S1: begin
                if (x == 1'b0) begin
                    state <= S2;
                    z <= 1'b0;
                end
                else begin
                    state <= S1;
                    z <= 1'b0;
                end
            end
            S2: begin
                if (x == 1'b1) begin
                    state <= S3;
                    z <= 1'b1;
                end
                else begin
                    state <= IDLE;
                    z <= 1'b0;
                end
            end
            S3: begin
                if (x == 1'b0) begin
                    state <= IDLE;
                    z <= 1'b0;
                end
                else begin
                    state <= S1;
                    z <= 1'b0;
                end
            end
            default: begin
                state <= IDLE;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
