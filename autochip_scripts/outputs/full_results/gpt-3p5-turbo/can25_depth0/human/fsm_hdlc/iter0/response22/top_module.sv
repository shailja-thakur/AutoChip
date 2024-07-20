module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

reg [2:0] state;
reg [5:0] counter;

parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;
parameter S5 = 3'b101;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S0;
        counter <= 0;
    end else begin
        case (state)
            S0: begin
                if (in == 1) begin
                    state <= S1;
                    counter <= 1;
                end
            end
            S1: begin
                if (in == 1) begin
                    state <= S2;
                    counter <= counter + 1;
                end else begin
                    state <= S0;
                    counter <= 0;
                end
            end
            S2: begin
                if (in == 1) begin
                    state <= S3;
                    counter <= counter + 1;
                end else begin
                    state <= S0;
                    counter <= 0;
                end
            end
            S3: begin
                if (in == 1) begin
                    if (counter < 5) begin
                        state <= S4;
                        counter <= counter + 1;
                    end else if (counter == 5) begin
                        state <= S5;
                        counter <= counter + 1;
                    end else if (counter >= 6) begin
                        state <= S5;
                        counter <= 0;
                    end
                end else begin
                    state <= S0;
                    counter <= 0;
                end
            end
            S4: begin
                if (in == 1) begin
                    if (counter < 5) begin
                        state <= S4;
                        counter <= counter + 1;
                    end else if (counter == 5) begin
                        state <= S5;
                        counter <= counter + 1;
                    end else if (counter >= 6) begin
                        state <= S5;
                        counter <= 0;
                    end
                end else begin
                    state <= S0;
                    counter <= 0;
                end
            end
            S5: begin
                if (in == 1) begin
                    state <= S4;
                    counter <= counter + 1;
                end else begin
                    state <= S0;
                    counter <= 0;
                end
            end
        endcase
    end
end

assign disc = (state == S2);
assign flag = (state == S3);
assign err = (state == S5);

endmodule
