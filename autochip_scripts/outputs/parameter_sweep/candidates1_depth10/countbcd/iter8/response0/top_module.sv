module top_module(
    input clk,
    input reset,
    output wire [3:1] ena,
    output reg [15:0] q);

    reg [15:0] q_reg;
    reg [3:1] ena_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q_reg <= 0;
            ena_reg <= 0;
        end else begin
            // Increment ones digit if enabled
            if (ena_reg[1]) begin
                if (q_reg[3:0] < 9) begin
                    q_reg[3:0] <= q_reg[3:0] + 1;
                end else begin
                    q_reg[3:0] <= 0;
                end
            end

            // Increment tens digit if enabled
            if (ena_reg[2]) begin
                if (q_reg[7:4] < 9) begin
                    q_reg[7:4] <= q_reg[7:4] + 1;
                end else begin
                    q_reg[7:4] <= 0;
                end
            end

            // Increment hundreds digit if enabled
            if (ena_reg[3]) begin
                if (q_reg[11:8] < 9) begin
                    q_reg[11:8] <= q_reg[11:8] + 1;
                end else begin
                    q_reg[11:8] <= 0;
                end
            end

            ena <= ena_reg;
        end
    end

    assign q = q_reg;

endmodule
