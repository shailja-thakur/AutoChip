module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    reg [3:1] state, next_state;
    reg [3:1] next_g;

    always @(posedge clk or negedge resetn) begin
        if(!resetn)
            state <= 3'b001;
        else
            state <= next_state;
    end

    always @(state or r) begin
        case(state)
            3'b001: begin // A
                if((r[1] == 0) && (r[2] == 0) && (r[3] == 0))
                    next_state = 3'b001;
                else if(r[1])
                    next_state = 3'b010;
                else if((r[1] == 0) && r[2])
                    next_state = 3'b011;
                else if((r[1] == 0) && (r[2] == 0) && (r[3] == 0))
                    next_state = 3'b100;
            end
            3'b010: begin // B
                if(r[1])
                    next_state = 3'b010;
                else if(!r[1] && g[1])
                    next_state = 3'b001;
            end
            3'b011: begin // C
                if(r[2])
                    next_state = 3'b011;
                else if(!r[2] && g[2])
                    next_state = 3'b001;
            end
            3'b100: begin // D
                next_state = 3'b001;
            end
        endcase
    end

    always @(state) begin
        case(state)
            3'b001: next_g = 3'b000;
            3'b010: next_g = 3'b100;
            3'b011: next_g = 3'b010;
            3'b100: next_g = 3'b001;
        endcase
    end

    always @(posedge clk or negedge resetn) begin
        if(!resetn)
            g <= 3'b000;
        else
            g <= next_g;
    end

endmodule
