module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    reg start;
    reg [2:0] state;
    reg [2:0] next_state;
    reg temp_z;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            start <= 1'b0;
            state <= 3'b000; // Initialize state to 000
            temp_z <= 1'b0; // Initialize temp_z to 0
        end else begin
            start <= ~areset;
            state <= next_state;
            z <= temp_z;
        end
    end

    always @(*) begin
        case (state)
            3'b000: begin
                if (start) begin
                    if (x) begin
                        next_state = 3'b010; // move to state 010 if x is 1
                        temp_z <= 1'b0;
                    end else begin
                        next_state = 3'b001; // move to state 001 if x is 0
                        temp_z <= 1'b1;
                    end
                end
            end

            3'b001: begin
                if (start) begin
                    if (x) begin
                        next_state = 3'b010; // move to state 010 if x is 1
                        temp_z <= 1'b0;
                    end
                end else begin
                    next_state = 3'b000; // move to state 000 if start is 0
                end
            end

            3'b010: begin
                if (start) begin
                    if (x) begin
                        next_state = 3'b010; // stay in state 010 if x is 1
                        temp_z <= 1'b0;
                    end else begin
                        next_state = 3'b011; // move to state 011 if x is 0
                        temp_z <= 1'b1;
                    end
                end
            end

            3'b011: begin
                if (start) begin
                    if (x) begin
                        next_state = 3'b010; // move to state 010 if x is 1
                        temp_z <= 1'b0;
                    end
                end else begin
                    next_state = 3'b000; // move to state 000 if start is 0
                end
            end

            default: begin
                next_state = 3'b000; // default state is 000
            end
        endcase
    end
endmodule
