module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    reg [2:0] state;
    wire [1:0] count;

    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else begin
            case (state)
                S0: begin
                    if (in)
                        state <= S1;
                    else
                        state <= S0;
                end
                S1: begin
                    if (in)
                        state <= S2;
                    else
                        state <= S0;
                end
                S2: begin
                    if (in)
                        state <= S3;
                    else
                        state <= S0;
                end
                S3: begin
                    if (in)
                        state <= S4;
                    else
                        state <= S0;
                end
                S4: begin
                    if (in)
                        state <= S4;
                    else
                        state <= S0;
                end
            endcase
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            count <= 2'b00;
        else begin
            if (state == S1 || state == S2 || state == S3 || state == S4) begin
                if (in)
                    count <= count + 1;
                else
                    count <= 2'b00;
            end
        end
    end

    always @(*) begin
        disc = 0;
        flag = 0;
        err = 0;

        case (state)
            S2: begin
                disc = 1;
            end
            S3: begin
                flag = 1;
            end
            S4: begin
                err = 1;
            end
        endcase

        if (count >= 2)
            disc = 1;
        if (count >= 5)
            count = 2'b00;
    end
endmodule
