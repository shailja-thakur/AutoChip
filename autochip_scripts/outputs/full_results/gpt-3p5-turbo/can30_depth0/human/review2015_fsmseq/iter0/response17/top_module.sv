module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    reg [3:0] state;
    reg [3:0] next_state;

    // State definitions
    localparam IDLE = 4'b0000;
    localparam S1 = 4'b0001;
    localparam S2 = 4'b0010;
    localparam S3 = 4'b0100;
    localparam FOUND = 4'b1000;

    // Output assignment
    assign start_shifting = (state == FOUND);

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        next_state = state;

        case (state)
            IDLE: begin
                if (data) begin
                    next_state = S1;
                end
            end
            S1: begin
                if (data) begin
                    next_state = S1;
                end else begin
                    next_state = S2;
                end
            end
            S2: begin
                if (data) begin
                    next_state = S3;
                end else begin
                    next_state = S1;
                end
            end
            S3: begin
                if (data) begin
                    next_state = FOUND;
                end else begin
                    next_state = S1;
                end
            end
            FOUND: begin
                next_state = FOUND;
            end
        endcase
    end
endmodule
